## To be used with acxi auto-tag feature, or any other program that
## supports this autotag file syntax.
## NOTE: any item left blank will not create a tag for that item.
## If FILE is left blank, that track file will not be tagged.
## Any collection/recording info item can be used more than 1 time,
## though some shouldn't be. For per track or track block items, reset
## values between track blocks to set the subsequent blocks for the new
## values, like DISCNUMBER%:, PERFORMER%:, DATE%:, YEAR%:

## COLLECTION/RECORDING INFORMATION ##
ALBUM%:
ARTIST%:
# repeat: 1 line per COMMENT, will be combined.
COMMENT%:
COMPOSER%:
CONDUCTOR%:
# use iso format so it is consistent: YYYY-MM-DD
DATE%:
DESCRIPTION%:
# Repeat if > 1 genre
GENRE%:
LABEL%:
LOCATION%:
ORGANIZATION%:
# repeat: 1 performer per entry.
PERFORMER%:
PUBLISHER%:
# 0 to 100, yields 0-5 stars usually, 1 star = 20.
RATING%:
# could be useful for tapers and live concert data about source
SOURCEMEDIA%:
VENUE%:
# YYYY
YEAR%:

## DISK INFORMATION ##
# leave blank unless > 1 disks, some media players will show: 1.1
# If a two or more disk set, place next one before the start of
# the second disk track list, and so on.
DISCNUMBER%:
# only use if > 1 disks.
DISCTOTAL%:
# total per disc, not per collection
TRACKTOTAL%:

## TRACK INFORMATION ##

# IMPORTANT: FILE%: must be last item per track because
# that will trigger the actual writing of the tags/comments to the flac file.
# TRACKNUMBER zero padded automatically. This is the per disk track number.
# Some playback devices will not sort correctly if not zero padded.
# FILE is path to file from the directory where auto.tag is located.
# Samples: FILE%:track12.flac or: FILE%:Disc One/track12.flac
# TITLE is track name
# VERSION is if alternate mix, or whatever, eg, > 1 versions of same track
# otherwise leave VERSION blank.
# Sample: 
# TRACKNUMBER%:2
# TITLE%:The Song We Love
# VERSION%:remix
# FILE%:d1track2.flac
TRACKNUMBER%:
PART%:
TITLE%:
VERSION%:
FILE%:

TRACKNUMBER%:
PART%:
TITLE%:
VERSION%:
FILE%:

TRACKNUMBER%:
PART%:
TITLE%:
VERSION%:
FILE%:

TRACKNUMBER%:
PART%:
TITLE%:
VERSION%:
FILE%:

TRACKNUMBER%:
PART%:
TITLE%:
VERSION%:
FILE%:

TRACKNUMBER%:
PART%:
TITLE%:
VERSION%:
FILE%:

TRACKNUMBER%:
PART%:
TITLE%:
VERSION%:
FILE%:

TRACKNUMBER%:
PART%:
TITLE%:
VERSION%:
FILE%:

TRACKNUMBER%:
PART%:
TITLE%:
VERSION%:
FILE%:

TRACKNUMBER%:
PART%:
TITLE%:
VERSION%:
FILE%:

TRACKNUMBER%:
PART%:
TITLE%:
VERSION%:
FILE%:

TRACKNUMBER%:
PART%:
TITLE%:
VERSION%:
FILE%:

TRACKNUMBER%:
PART%:
TITLE%:
VERSION%:
FILE%:

TRACKNUMBER%:
PART%:
TITLE%:
VERSION%:
FILE%:


