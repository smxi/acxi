## To be used with acxi autotag feature, or any other program that
## supports this autotag file syntax.
## You can generate this file, with prefilled TRACK blocks including
## file names using: acxi --autotag-create -s [recording folder].
## For single disk collections: --autotag-create-single
## will also number the tracks, and add track total.
## NOTE: any item left blank will not create a tag for that item.
## If FILE is left blank, that track file will not be tagged.
## Any collection/recording info item can be used more than 1 time,
## though some shouldn't be. For per track or track block items, reset
## values between track blocks to set the subsequent blocks for the new
## values, like DISCNUMBER%:, PERFORMER%:, DATE%:, YEAR%:
## Check tags: metaflac --list --block-type=VORBIS_COMMENT *.flac
## Check images: metaflac --list --block-type=PICTURE *.flac | grep -A8 -i metadata
## Use -E option to prefill ARTIST, DATE, YEAR, PERFORMER, TITLE fields 
## automatically. Requires specially formatted info.txt file. See man page for
## details.
## NOTE: almost no media players support > 1 tag type the way the specifications 
## say, so multiple values, like GENRE, ARTIST, often fail to work as intended.

## SPECIAL FEATURES
# Comma separated tag names to be used per file, and unset after each file
# is tagged. This terminates default cascade tag to next file behavior.
# This allows you for instance to set a COMPOSER for a single track.
UNIQUE%:

## COLLECTION/RECORDING NAME/CREATORS ##
ALBUM%:
# name to sort under
ALBUMSORT%:
# for tag based collections, 1 tag per artist so you can find 
# them based on the tag. Not same as PERFORMER, which is the people
# who performed the piece, like members of the band.
ARTIST%:
# Multi-Artist only
ALBUMARTIST%:
# Symphony, Orquestra. Usually group playing non-original music
ENSEMBLE%:
# Generally Classical fields
COMPOSER%:
CONDUCTOR%:
OPUS%:
# 1 performer per entry. For example members of band.
PERFORMER%:
PERFORMER%:
PERFORMER%:
PERFORMER%:
PERFORMER%:
PERFORMER%:
PERFORMER%:
PERFORMER%:
PERFORMER%:
PERFORMER%:

## RECORDING COMMENTS. NOTE: COMMENT PREFERRED OVER DESCRIPTION ##
# repeat: 1 line per COMMENT, will be combined.
COMMENT%:
COMMENT%:
COMMENT%:
COMMENT%:
COMMENT%:

## FILE DISPLAY IMAGES ##
# creates image data in music file: 
# Only default cover type supported due to some glitches I found in metaflac
# implementation. The image path is from where auto.tag is located.
# Sample: IMAGE%:images/cover.jpg
# WARNING: the image file data will be added to each music file, so
# make sure to optimize the picture you are going to add as much as 
# possible, 75% jpeg quality at 3-400px width gives a good quality but 
# small file size. Remove all image data with: --remove-images
# metaflac --remove --block-type=PICTURE,PADDING --dont-use-padding *.flac
# To avoid errors, acxi will only embed an image if none have been embedded.
IMAGE%:

## RECORDING INFO ##
# Repeat if > 1 genre (very poor support in media players).
GENRE%:
# 0 to 100, yields 0-5 stars usually, 1 star = 20.
RATING%:
# Use ISO format for consistent and sortable dates: YYYY-MM-DD
DATE%:
# Format: YYYY
YEAR%:
LOCATION%:
VENUE%:
# If different from the person who produced or recorded it
MIXER%:
# Person responsible, either taper, funder, etc.
PRODUCER%:
PUBLISHER%:
REMIXER%:
# e.g.: label, taper group, etc.
ORGANIZATION%:
# Database type IDs
CDDB%:
ETREE%:
SHNID%:

## TECHNICAL INFORMATION ##
# tech info about the flac generation
ENCODING%:
# could be useful for tapers and live concert data about source
SOURCE%:
SOURCE%:
SOURCE%:
# the original media eg, tape, vinyl, cd, dat, etc.
SOURCEMEDIA%:

## DISK INFORMATION ##

# only use if > 1 disks.
DISCTOTAL%:
# leave blank unless > 1 disks, some media players will show: 1.1
# If a two or more disk set, place next one before the start of
# the second disk track list, and so on.
DISCNUMBER%:
# for multidisc sets
DISCSUBTITLE%:
# total per disc, not per collection
TRACKTOTAL%:

## TRACK INFO ##
# To make the value of any field above empty use: UNSET as the field value.
#
# TRACKNUMBER and FILE required, title not known?: suggest TITLE%:Unknown 
# IMPORTANT: FILE%: must be last item per track because
# that will trigger the actual writing of the tags/comments to the flac file.
# REPLAYGAIN: When --autotag-create is used, existing REPLAYGAIN tags will 
# be included in the per track block of tags.
# TRACKNUMBER zero padded automatically. This is the per disk track number.
# Some playback devices will not sort correctly if not zero padded.
# FILE is path to file from the directory where auto.tag is located.
# Samples: FILE%:track12.flac or: FILE%:Disc One/track12.flac
# TITLE is track name
# VERSION is extra info on the song, like encore, accoustic, radio edit, 12 inch remix,
# live. Leave blank if no extra info has to be shown.
# Sample: 
# TRACKNUMBER%:4
# TITLE%:The Song We Love
# VERSION%:remix
# PART%:
# FILE%:d2track4.flac

TRACKNUMBER%:
TITLE%:
VERSION%:
PART%:
FILE%:

TRACKNUMBER%:
TITLE%:
VERSION%:
PART%:
FILE%:

TRACKNUMBER%:
TITLE%:
VERSION%:
PART%:
FILE%:

TRACKNUMBER%:
TITLE%:
VERSION%:
PART%:
FILE%:

TRACKNUMBER%:
TITLE%:
VERSION%:
PART%:
FILE%:

TRACKNUMBER%:
TITLE%:
VERSION%:
PART%:
FILE%:

TRACKNUMBER%:
TITLE%:
VERSION%:
PART%:
FILE%:

TRACKNUMBER%:
TITLE%:
VERSION%:
PART%:
FILE%:

TRACKNUMBER%:
TITLE%:
VERSION%:
PART%:
FILE%:

TRACKNUMBER%:
TITLE%:
VERSION%:
PART%:
FILE%:

TRACKNUMBER%:
TITLE%:
VERSION%:
PART%:
FILE%:

TRACKNUMBER%:
TITLE%:
VERSION%:
PART%:
FILE%:

TRACKNUMBER%:
TITLE%:
VERSION%:
PART%:
FILE%:

TRACKNUMBER%:
TITLE%:
VERSION%:
PART%:
FILE%:

TRACKNUMBER%:
TITLE%:
VERSION%:
PART%:
FILE%:
