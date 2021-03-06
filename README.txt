README for acxi - a command line audio file conversion tool

See acxi.changelog for changes.

See https://smxi.org/docs/acxi-man.htm for the HTML version of the the man 
page. 

See https://smxi.org/docs/acxi-options.htm for HTML version of help menu 
options.

================================================================================
INSTALLATION
--------------------------------------------------------------------------------

Easy way to install. Change paths on local system if required.

With acxi 3.2.16 or newer, self updater: sudo acxi -U

Or, to install the man and acxi files manually:

These are for GNU/Linux. These use a redirecting shortcut from smxi.org
 sudo wget -O /usr/local/bin/acxi smxi.org/acxi

Then make executable:
 sudo chmod +x /usr/local/bin/acxi

For man page:
 sudo wget -O /usr/local/share/man/man1/acxi.1 smxi.org/acxi.1

If you prefer to use the full GitHub paths:

Program:
 sudo wget -O /usr/local/bin/acxi https://github.com/smxi/acxi/raw/stable/acxi

Man page:
 sudo wget -O /usr/local/share/man/man1/acxi.1 https://github.com/smxi/acxi/raw/stable/acxi.1
 
If you want to use the -U self-updater option, both acxi and the man page must 
be present on your system, and paths to them set either by placing them in the 
default locations above, or adding the required configuration paths.

================================================================================
ABOUT
--------------------------------------------------------------------------------
acxi is a tool that syncs/converts lossless (flac, wav, raw) music libraries to 
compressed (mp3,ogg,opus) versions of the lossless library. It also can convert 
aif, raw, shn, and wav to flac. 

acxi is developed as features are requested or discovered useful. It will in 
general 'just work' for as long as it's installed, though it is a good idea to 
check for updates now and then since bugs get fixed, new features are added or 
extended. Changes will not break existing configurations.

acxi is used to process the lossless files generated by programs like abcde, the 
audio cd ripping tool, or other lossless collections, and makes for very easy 
updating/syncing of all your music collections.

It also copies over all associated data, like .txt, .jpg, .png files. You can 
add or remove these file types using either top configurations, configuration 
file, -a [one or more comma separated extensions] to add/apppend a file type 
temporarily, or -c [comma separated extension list] to supply a new list. This 
results in  you having a full copy of your originals in compressed format. 

It also allows you to set exclude filenames/directories so you don't add those 
undesired files or folders to your synced collection. It further supports, via 
--clean, the option to remove clutter from your lossy collection.

It allows setting all variables, like compression rates, target and source 
directories, and and so on. 

For instance, say you have:
/home/fred/media/main
which contains your flac music directories, and you want to sync up your ogg 
versions in:
/home/fred/media/ogg
You would run: acxi -s /home/fred/media/main -d /home/fred/media/ogg
and acxi would mirror the directory structure, copy over all the jpg, png, txt, 
etc, type files, and then encode your flacs to ogg. 

If your ogg, opus, or mp3, directory is located at: 
/home/fred/media/main/ogg
that is, in your 'main' directory, acxi will handle that, and ignore that 
directory when syncing.

If you run acxi routinely, it will just copy/sync over changed or new files. 
Note that acxi will not change to a different compression level already 
compressed versions, so if you want to change your compression levels, you have 
to use the -f/--force option.

It can also be used to autotag your collection. Read the man page for more on 
auto tagging. It can also generate new checksum files (md5 and ffp) if you need 
those for some reason, and verify existing md5 hashes and flac file integrity, 
embed cover art into existing tagged files, and much more.

================================================================================
DEPENDENCIES
--------------------------------------------------------------------------------
For backward compatibility, acxi requires only Perl 5.010 (or newer), so it 
should run on anything. Several features (copy, make directory, find files) were 
moved from *nix commands to Perl native commands in version 3, which should make 
acxi fully platform agnostic.

* AAC/M4A encoding requires: ffmpeg with either native aac codec, or libfdk_aac 
  (best, Debian/Ubuntu package libfdk-aac2). If you want to preserve tags, use 
  m4a, if you use aac they will not transfer.

* MP3 encoding requires: lame and flac (if source file is a flac, MP3 encoding 
  does not support wav or raw formats).
  
* Ogg encoding requires oggenc (Debian/Ubuntu package: vorbis-tools).

* Opus encoding requires opusenc (Debian/Ubuntu package: opus-tools).
  
* SHN -> FLAC conversion requires the codec 'shorten' and ffmpeg.

* --autotag requires metaflac plus a specially formatted auto.tag file placed 
  inside each album/collection directory.

* --checksum / --checksum-delete checksum generation require metaflac and md5sum 
  (or a comparable md5 generating command line utility).
  
* --checksum-verify requires md5sum (or comparable tool) and flac.
  
* -U self updater requires curl, and valid paths for currently installed acxi 
  and acxi.1 man page. Will not update if both acxi and acxi.1 are not present 
  on your system, and correct paths set.

In theory, acxi 3.x should run on Windows and Macs, but I have not tested that, 
but as long as the source/destination directory paths and the 
application/configuration paths are correct, it should 'just work'.

================================================================================
CONFIGURATION
--------------------------------------------------------------------------------
acxi supports configuration files at either /etc/acxi.conf, or user override 
files $XDG_CONFIG_HOME/acxi.conf, $HOME/.acxi.conf, or $HOME/.config/acxi.conf. 
The user configuration values override any /etc/acxi.conf values.

See the man page for complete explanations.

If your system does not have the $HOME or $XDG_CONFIG_HOME environmental 
variables (Windows, for example), you can use the manual config file path option
$CONFIGURATION_DIRECTORY='';
to create a path to your acxi.conf configuration file.

See the top of acxi, or the man page, for instructions on how to create the 
configuration items. Note that user values in configuration files do not use the 
$ you see in the top user configuration section, for example, $SOURCE_DIRECTORY 
would be used as: SOURCE_DIRECTORY=path in your configuration file.

You must at a minimum set your source and destination directories the first time 
you run acxi, either using the -s/--source and -d/--destination options, or in 
the USER VARIABLES section on the top of the file, or in a configuration file.

acxi defaults to flac for input, and defaults to the following quality levels 
for output:

* aac/m4a: 160

* flac: 4

* ogg: 7

* mp3: 3

* opus: 144

acxi also copies most common file types from source to destination directories. 

Output type can be set with -o/--output, input type with -i/--input, and quality 
level with -q/--quality options. The file types to copy over can be changed with 
-c/--copy, -a/--append, or configuration file values.

Once you set your input/output directory paths (using either -s / -d options, or 
creating a configuration file), you can use the --test option to see what acxi 
would have done, then, once you have confirmed everything is working as 
expected, you can start syncing your music files.

You can change the screen output from:

* none (--quiet, --log 0)

* single line (--basic, --log 1)

* verbose (--verbose, --log 2)

* full, with all conversion tool outputs (--full, --log 3)

* debug, all output, incuding at times various debugging events 
  (--debug, --log 4)

These values can also be set in configuration files using LOG_LEVEL=[0-4].

================================================================================
AAC
--------------------------------------------------------------------------------

You can usually install the Frauenhofer libfdk_aac codec if you use the proper 
non-free repositories. In Debian/Ubuntu, the package is libfdk_aac2. Otherwise 
you can use the ffmpeg native aac codec, but it has been tested and found less 
good than the fdk_aac codec. Your call. 

Read more about the technical comparisons here:
https://trac.ffmpeg.org/wiki/Encode/AAC

FFMPEG does not transfer tags when the file format is aac, but it does when it's 
m4a, so if you have tagged flac source files, then use m4a instead of aac and 
most of your tags will transfer fine automatically.

================================================================================
SHN SHORTEN
--------------------------------------------------------------------------------
Finding the shorten codec can be a pain, here's a few sources that may help. You 
probably already have the codec if you have shn files and have been playing 
them.

http://wiki.etree.org/index.php?page=SoftwareYouNeed
See section: Uncompress 
http://adventuresinswitching.blogspot.com/2008/04/convert-shn-shorten-to-mp3-or-flac-in.html
has a good selection of methods for Linux, including compiling directions.

Check for a package/port called 'shorten' in *nix systems, and for Windows, 
you'll want to find the shorten.exe. 

Arch, Ubuntu, etc, have the shorten package available. deb-multimedia.org has 
the shorten codec package for Debian.

For a collection of plugins and other shorten items:
http://shnutils.freeshell.org/shorten/

http://shnutils.freeshell.org/shorten/dist/src/ has the shorten 
tar.gz files if you want to compile the codec yourself.

$ ./configure
$ make
$ make check
$ sudo make install
