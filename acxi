#!/usr/bin/env perl
# acxi_v3
# Trying to do a rewrite of acxi, mostly just to get totally into it
# myself, to be able to understand it better and help more constructively.
#
# All documentation for this program is embedded in the end of this file, 
# in POD format for easier formatting of output.
#
# The latest version can be obtained via git, like this:
#   git clone git://gbg.oddware.net/acxi.git
#
# Odd Eivind Ebbesen <oddebb@gmail.com>, 2011-04-07 02:20:24

## Start code
use strict;
use warnings;
use Getopt::Long qw(:config auto_version auto_help no_ignore_case);
use Pod::Usage;
use File::Find;
use File::Basename;
use File::Spec;
use Cwd;

## Internal settings:

# Getopt::Long will automatically control --version if this variable is set:
$main::VERSION = "3.0.0";

my $help = 0;   # for Pod::Usage brief help msg
my $man = 0;    # for Pod::Usage full documentation

# Exit codes, copied from Linux sysexits.h, to follow standards.
# TODO: replace these values with error codes from %! (see perlvar).
my %EX_ = (
    OK          => 0,   # successful termination 
    _BASE       => 64,  # base value for error messages 
    USAGE       => 64,  # command line usage error 
    DATAERR     => 65,  # data format error 
    NOINPUT     => 66,  # cannot open input 
    NOUSER      => 67,  # addressee unknown 
    NOHOST      => 68,  # host name unknown 
    UNAVAILABLE => 69,  # service unavailable 
    SOFTWARE    => 70,  # internal software error 
    OSERR       => 71,  # system error (e.g., can't fork) 
    OSFILE      => 72,  # critical OS file missing 
    CANTCREAT   => 73,  # can't create (user) output file 
    IOERR       => 74,  # input/output error 
    TEMPFAIL    => 75,  # temp failure; user is invited to retry 
    PROTOCOL    => 76,  # remote error in protocol 
    NOPERM      => 77,  # permission denied 
    CONFIG      => 78,  # configuration error 
    _MAX        => 78   # maximum listed value 
);

# Not used yet, but as a future thought...
my %ACXI = (
    version     => $main::VERSION, 
    date        => q(2011-04-15),
    desc        => q(Audio file conversion script), 
    authors     => q(Harald Hope, Odd Eivind Ebbesen <odd@oddware.net>), 
    credits     => q(Jason L. Buberel <jason@buberel.org>, Evan Boggs <etboggs@indiana.edu>), 
    url         => q(http://techpatterns.com/forums/about1491.html)
);
# Internal log/message levels (use corresponding values, not variables in config files)
my %LOG = (
    quiet       => 0, 
    info        => 1, 
    verbose     => 2, 
    debug       => 3
);

my %LINE_LEN = (
    short => 65, 
    long  => 75
);

my @CONFIGS = (
    qq(/etc/acxi.conf), 
    qq($ENV{HOME}/.acxi.conf)
);

my @INPUT_TYPES  = qw(flac wav raw);
my @OUTPUT_TYPES = qw(ogg mp3);

#my %ARG_ENCODER_VERBOSITY = (
#    mp3 => %{$LOG{QUIET} => "--quiet";
#);
## User settings:
# In the config file, you just write KEY = value, eg:
# DIR_PREFIX_SOURCE = /home/user/flac 
# Settings not present in the config file will stay as defined here.
my %USER_SETTINGS = (
    LOG_LEVEL           => $LOG{info}, 
    DIR_PREFIX_SOURCE   => qq($ENV{HOME}/flac), 
    DIR_PREFIX_DEST     => qq($ENV{HOME}/ogg), 
    QUALITY             => 7, 
    INPUT_TYPE          => q(flac), 
    OUTPUT_TYPE         => q(ogg), 
    COPY_TYPES          => q(bmp,jpg,jpeg,tif,doc,docx,odt,pdf,txt), 
    COMMAND_OGG         => q(/path/to/oggenc), 
    COMMAND_LAME        => q(/path/to/lame), 
    COMMAND_FLAC        => q(/path/to/flac), 
    COMMAND_METAFLAC    => q(/path/to/metaflac)
);
## END user settings

# This can be used to export enclosed vars if this script were to be used as a module
#use vars qw(%ACXI);

## Functions:

sub acxi_log {
    # The result of calling this function without a level param, is that
    # the message is shown at which ever level is set, except "quiet",
    my ($msg, $lvl) = @_;
    if ($USER_SETTINGS{LOG_LEVEL} == $LOG{quiet}) {
        return;
    }
    if (!defined($lvl)) {
        $lvl = $USER_SETTINGS{LOG_LEVEL};
    }
    if ($lvl <= $USER_SETTINGS{LOG_LEVEL}) {
        print($msg);
    }
}

sub line {
    # A replacement for predefining vars with different lines.
    # Just generate them on the fly.
    my ($char, $length, $newline) = @_;
    my $buf = ($char x $length);
    $buf .= "\n" if ($newline);
    return $buf;
}

sub header {
    # Returns a string padded right and left with a fill char, 
    # for use as a pretty header
    my ($char, $msg, $maxlength, $newline) = @_;
    my ($lstr, $llen, $rstr, $rlen, $msglen, $calctotal);
    $msglen = length($msg);
    $llen = int(($maxlength - $msglen - 2) / 2);
    $calctotal = ($llen * 2) + $msglen + 2;
    if ($calctotal > $maxlength) {
        $rlen = $llen - 1;
    } elsif ($calctotal < $maxlength) {
        $rlen = $llen + 1;
    } else {
        $rlen = $llen;
    }
    $lstr = ($char x $llen);
    $rstr = ($char x $rlen);
    $msg = $lstr . " " . $msg . " " . $rstr;
    $msg .= "\n" if ($newline);
    return $msg;
}

sub read_config_file {
    my ($file, $var, $val);
    # Config files should be passed in an array as a param to this function.
    # Default intended use: global @CONFIGS;
    foreach $file (@_) {
        next unless open (CONFIG, "$file");
        while (<CONFIG>) {
            chomp;
            s/#.*//;
            s/^\s+//;
            s/\s+$//;
            next unless length;
            ($var, $val) = split(/\s*=\s*/, $_, 2);
            $USER_SETTINGS{$var} = $val;
        }
    }
    # If $USER_TYPES is set (from old config file), set $USER_SETTINGS{COPY_TYPES}
    # to that value. If COPY_TYPES is set in the config file instead, it will have 
    # been set in USER_SETTINGS already, from the read loop above.
    # Splitting COPY_TYPES to an array will be done later, as needed.
    if (defined($USER_SETTINGS{USER_TYPES})) {
        $USER_SETTINGS{COPY_TYPES} = $USER_SETTINGS{USER_TYPES};
        delete($USER_SETTINGS{USER_TYPES}); # don't need two copies of this setting
    }
}

sub dump_config {
    # Dump config for the user to easily see the settings in effect
    my ($maxlen, $curlen, $lvl_forced) = 0;
    my $strbuf = "";
    my $lvl = \$USER_SETTINGS{LOG_LEVEL};   # use reference for less typing...
    if ($$lvl < 1) {
        $$lvl = 1;
        $lvl_forced = 1;
    }

    # First, loop through hash and find the longest key, 
    # then loop once more, and print contents aligned
    my @keys = sort(keys(%USER_SETTINGS));
    foreach (@keys) {
        $curlen = length($_);
        $maxlen = $curlen if ($curlen > $maxlen);
    }
    acxi_log(line("=", $LINE_LEN{long}, 1), $$lvl);
    acxi_log(header("=", qq(Current configuration:), $LINE_LEN{long}, 1), $$lvl);
    foreach my $key (@keys) {
        $strbuf = sprintf("%-${maxlen}s", $key);
        acxi_log(qq($strbuf = $USER_SETTINGS{$key}\n), $$lvl);
    }
    if ($lvl_forced) {
        acxi_log(qq/* Note: LOG_LEVEL was forced to 1 (info), as the user setting was 0 (quiet)\n/, $$lvl);
    }
    acxi_log(line("=", $LINE_LEN{long}, 1), $$lvl);
}

# Create destination directories as in source
sub dircopy {
    # create reference vars for less typing
    my $src = \$USER_SETTINGS{DIR_PREFIX_SOURCE};
    my $dst = \$USER_SETTINGS{DIR_PREFIX_DEST};

    acxi_log(line("-", $LINE_LEN{short}, 1), $LOG{verbose});
    acxi_log(header("-", qq(Syncing source and destinations directories...), $LINE_LEN{short}, 1), 
        $LOG{verbose});

    # Embedding check for src/dst dirs here, instead of in separate function
    if (! -d qq($$src)) {
        acxi_log(qq(Error: Source directory "$$src" does not exist. Exiting.\n), 
            $LOG{info});
        exit $EX_{IOERR};
    }
    if (! -d qq($$dst)) {
        acxi_log(qq(Error: Destination directory "$$dst" does not exist. Exiting.\n), 
            $LOG{info});
        exit $EX_{IOERR};
    }

    find(\&dircopy_helper, $$src);
    acxi_log(header("-", qq(Directory syncronization complete), $LINE_LEN{short}, 1), $LOG{verbose});
}

# Helper function for File::Find ("wanted")
sub dircopy_helper {
    # not symlink, is dir, not . or .. and no newline
    if (! -l && -d && ! /^\.{1,2}$/ && ! /\n$/) {
        my $srcx = qq($USER_SETTINGS{DIR_PREFIX_SOURCE});
        my $dstx = qq($USER_SETTINGS{DIR_PREFIX_DEST});
        my $newdir = $File::Find::name;
        $newdir =~ s/$srcx/$dstx/;
        acxi_log(line("-", $LINE_LEN{short}, 1), $LOG{verbose});
        acxi_log(qq(Creating new directory:\n\t$newdir\n), $LOG{verbose});
        mkdir(qq($newdir)) or acxi_log(qq(Failed to create directory: "$newdir" -  $!\n), $LOG{debug});
    }
    # not quite sure yet whether it's best to put all the rest code for conversion/copying here, 
    # or if it's better to create a separate function for that.
}

sub verify_ext_binaries {
    # Check if the set paths to external commands point to valid executables.
    # If not, try to locate them, and if not found, unset the paths.
    # Use references for less typing, and to be able to change vars directly
    # when passed to other functions.
    my $flac = \$USER_SETTINGS{COMMAND_FLAC};
    my $mflac = \$USER_SETTINGS{COMMAND_METAFLAC};
    my $lame = \$USER_SETTINGS{COMMAND_LAME};
    my $ogg = \$USER_SETTINGS{COMMAND_OGG};

    is_executable($$flac) or locate_binary($$flac, $flac);
    is_executable($$mflac) or locate_binary($$mflac, $mflac);
    is_executable($$lame) or locate_binary($$lame, $lame);
    is_executable($$ogg) or locate_binary($$ogg, $ogg);
}

sub is_executable {
    # Test if a file exists and can be executed by the real UID
    my $file = shift;
    return (-X $file);
}

sub locate_binary {
    # Try to locate file in $ENV{PATH}
    # $slot must be passed as a reference
    my ($filename, $slot) = @_;
    my $fullpath = "";
    $filename = fileparse($filename);
    foreach my $path (split/:/,$ENV{PATH}) {
        $fullpath = File::Spec->catfile($path, $filename);
        if (is_executable($fullpath)) {
            $$slot = $fullpath; # important to dereference $slot here
            return;
        }
    }
    # If execution reaches this point, no executable by given name was 
    # found, so set the slot empty
    $$slot = "";
}

sub check_io_formats {
    # Check if the specified input/output formats are valid, 
    # and exit script if not.
    my $ifmt = \$USER_SETTINGS{INPUT_TYPE};     # ref
    my $ofmt = \$USER_SETTINGS{OUTPUT_TYPE};    # ref
    my $iok = 0;
    my $ook = 0;

    foreach (@INPUT_TYPES) {
        $iok = 1 if $_ eq $$ifmt;
    }
    foreach (@OUTPUT_TYPES) {
        $ook = 1 if $_ eq $$ofmt;
    }
    if (1 == $iok) {
        acxi_log(qq(Error: input format "$$ifmt" not supported.\n), $LOG{info});
        acxi_log(qq(Supported formats: ) . join(", ", @INPUT_TYPES) . "\n", $LOG{info});
        exit $EX_{CONFIG};
    }
    if (1 == $ook) {
        acxi_log(qq(Error: output format "$$ofmt" not supported.), $LOG{info});
        acxi_log(qq(Supported formats: ) . join(", ", @OUTPUT_TYPES) . "\n", $LOG{info});
        exit $EX_{CONFIG};
    }
    return $EX_{OK};
}

#sub set_arg_audio {
#    my ($llvl, $itype, $otype) = @_;
#    if ($llvl eq $LOG{quiet}) {
#        $ARG_ENCODER{$otype} = "--silent";
#    }
#}

## Entry point:

# read config file first, and _then_ set CLI options to override
read_config_file(@CONFIGS);
GetOptions(
    "c|copy=s" => \$USER_SETTINGS{COPY_TYPES}, 
    "d|destination=s" => \$USER_SETTINGS{DIR_PREFIX_DEST}, 
    "f|force" => "",
    "i|input=s" => \$USER_SETTINGS{INPUT_TYPE}, 
    "o|output=s" => \$USER_SETTINGS{OUTPUT_TYPE}, 
    "q|quality=i" => "", 
    "s|source=s" => \$USER_SETTINGS{DIR_PREFIX_SOURCE},
    "V|version" => sub { Getopt::Long::VersionMessage($EX_{OK}) },
    "v|verbose+" => \$USER_SETTINGS{LOG_LEVEL}, # increases existing level by 1 for each '-v' given
    "Q|quiet|silent" => sub { $USER_SETTINGS{LOG_LEVEL} = $LOG{quiet} }, 
    "l|level=i" => \$USER_SETTINGS{LOG_LEVEL}, 
    "dump" => sub { dump_config(); exit $EX_{OK}; },
    "h|help|?" => \$help, 
    man => \$man
) or pod2usage(-exitstatus => $EX_{DATAERR}, -verbose => $LOG{info});
pod2usage($EX_{OK}) if $help;
pod2usage(-exitstatus => $EX_{OK}, -verbose => $LOG{verbose}) if $man;

# debug..
#dump_config();
#verify_ext_binaries();
#dump_config();
#dircopy();
if (check_io_formats() == $EX_{OK}) {
    acxi_log("Formats OK\n");
}


__END__

##########################################################################
### POD documentation (a lot more flexible than inline help functions) ###
##########################################################################

=pod

=encoding utf8

=head1 NAME

acxi - wrapper script for converting various audio formats to ogg or mp3.

=head1 VERSION

=for comment Remember to change the version number here to the same as $main::VERSION

3.0.0  @2011-05-11

=head1 DESCRIPTION

acxi simplifies converting whole directories of one audio format to another. The audio conversion itself is done through native tools (flac, metaflac, oggenc, lame), but eases the job of copying extra files (like coverart, lyrics, etc.) and recreating directory structures recursively.

=head1 SYNOPSIS

B<acxi> [options]

=head1 OPTIONS

=over

=item B<-c, --copy>=LIST

List of alternate data types to copy to output type directories. Must be comma separated, no spaces, see sample.

=item B<-d, --destination>=PATH

The path to the directory where you want the processed (eg, ogg) files to go.

=item B<-f, --force>

Overwrite destination files without confirmation even if they already exist.

=item B<-i, --input>=FORMAT

Input type/format. Supported values are: flac, wav, raw,

=item B<-o, --output>=FORMAT

Output type/format. Supported values are: ogg, mp3.

=item B<-q, --quality>=VALUE

Encoding quality. For ogg, accepted values are 1-10, where 10 is the best quality, and the bigggest file size. For mp3, accepted values are 0-9 (VBR), where 0 is the best quality, and the biggest file size.

=item B<-Q, --quiet, --silent>

Supresses all output by setting the user setting LOG_LEVEL to 0 (quiet).

=item B<-v, --verbose>

Increases user setting LOG_LEVEL by one for each invocation given on the command line. If LOG_LEVEL is already set to 3 (debug), then this option has no effect.
Recognized values are: 

=item B<-s, --source>=PATH

The source/root directory for your input files (flac/wav/raw).

=item B<-?, -h, --help>

This help text.

=item B<-m, --man>

Shows the full documentation for acxi in automatically generated man page format.

=item B<-V, --version>

Print acxi version number and Perl + Getopt version numbers.

=back

=head1 EXAMPLES

Copy *.png and *.jpg files found in the source directories, set top level source directory to /path/to/flac/, set top level destination directory to /path/to/ogg/, force overwrite if destination files already exist, set quality for en encoder to 6 and increase the preset verbosity levels by 2.
    acxi --copy png,jpg --source /path/to/flac/ --destination /path/to/ogg/ -f -q 6 -v -v 

=head1 CONFIGURATION

F</etc/acxi.conf> (systemwide), F<~/.acxi.conf> (user)

The systemwide config is read first if found, then the user config if found, and then command line parameters if set.

The configuration file format is OPTION=value on one line each. Recognized options are:
    LOG_LEVEL=<0-3>
    DIR_PREFIX_SOURCE=/path/to/dir
    DIR_PREFIX_DEST=/path/to/dir
    QUALITY=...
    INPUT_TYPE=<flac|ogg|mp3>
    OUTPUT_TYPE=<flac|ogg|mp3>
    COPY_TYPES=file-extension,file-extension,... (without '.')
    COMMAND_OGG=/path/to/ogg
    COMMAND_FLAC=/path/to/flac
    COMMAND_METAFLAC=/path/to/metaflac
    COMMAND_LAME=/path/to/lame


=head1 AUTHORS

=over

=item *

Harald Hope <http://smxi.org>

=item *

Odd Eivind Ebbesen <odd@oddware.net>

=back

=cut

