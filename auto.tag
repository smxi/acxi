## To be used with acxi autotag feature, or any other program that
## supports this autotag file syntax.
## You can generate this file, with prefilled TRACK blocks including
## file names using: acxi --autotag-create -s [recording folder].
## NOTE: any item left blank will not create a tag for that item.
## If FILE is left blank, that track file will not be tagged.
## Any collection/recording info item can be used more than 1 time,
## though some shouldn't be. For per track or track block items, reset
## values between track blocks to set the subsequent blocks for the new
## values, like DISCNUMBER%:, PERFORMER%:, DATE%:, YEAR%:
## Check tags: metaflac --list --block-type=VORBIS_COMMENT *.flac

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
COMPOSER%:
# Classical fields
CONDUCTOR%:
OPUS%:
# 1 performer per entry. For example members of band.
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
DESCRIPTION%:

## FILE DISPLAY IMAGES ##
# creates image data in music file: 
# [TYPE]|[MIME-TYPE]|[DESCRIPTION]|[WIDTHxHEIGHTxDEPTH[/COLORS]]|FILE
# In general, you can leave mime-type, description, widthxheight blank, 
# FILE and TYPE [number between 0-20, see docs] should be filled out.
# Leave | in. 3:cover, front; 4:cover, back; 5:leaflet page; 
# 8: artist/performer; 15:during performance; 19: band/artist logo; 
# FILE should be path from where auto.tag is located.
# Sample: IMAGE%:3||||images/cover.jpg
# WARNING: the image file data will be added to each music file, so
# make sure to optimize the picture you are going to add a as much as 
# possible, 75% jpeg quality at 400px width gives a good quality but 
# small file size.
IMAGE%:

## RECORDING INFO ##
# Repeat if > 1 genre
GENRE%:
# 0 to 100, yields 0-5 stars usually, 1 star = 20.
RATING%:
# Suggestion: use ISO format for consistent and sortable dates: YYYY-MM-DD
DATE%:
# Format: YYYY
YEAR%:
LOCATION%:
VENUE%:
LABEL%:
PRODUCER%:
PUBLISHER%:
ORGANIZATION%:

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
# TRACKNUMBER zero padded automatically. This is the per disk track number.
# Some playback devices will not sort correctly if not zero padded.
# FILE is path to file from the directory where auto.tag is located.
# Samples: FILE%:track12.flac or: FILE%:Disc One/track12.flac
# TITLE is track name
# VERSION is if alternate mix, or whatever, eg, > 1 versions of same track
# otherwise leave VERSION blank. eg: "live", "acoustic", "Radio Edit" "12 inch remix" 
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
