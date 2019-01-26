#!/bin/bash

# Load helper functions.
# /////////////////////////////////////////////////////////////////////////////
source utils.sh

# Search for available sources. (Only support .wav file for now.)
# /////////////////////////////////////////////////////////////////////////////
print_title "Search for available sources"
SOURCES_PATH="sources"
declare -a SOURCES
for file in $SOURCES_PATH/*; do
  mime_type=$(get_mime_type "$file")
  if [ $mime_type != "audio/x-wav" ]; then
    print_warning "Skip $file whose MIME type is $mime_type\n"
    continue
  fi
  SOURCES+=($file)
done

if [ ${#SOURCES[@]} -eq 0 ]; then
    print_error "No available sources. Finish."
    exit
fi

print_hint "The following files are ready:"
for file in ${SOURCES[@]}; do
  echo $file
done
echo ""

# Generate the commands for the available encoders on the different platforms.
# /////////////////////////////////////////////////////////////////////////////
print_title "Search for available encoders"
# Get the platform type:
# -1: Unsupported or unknown platform
#  0: macOS(OS X) / Darwin
PLATFORM=$(get_platform_type)

# Create an array to store the commands.
# The input file and the output file will be named as INPUT and OUTPUT
# respectively. They needs to be replaced with the real file names before
# these commands are executed.
declare -a COMMANDS
IN_FILE="INPUT"
OUT_FILE="OUTPUT"

ENCODERS_PATH="encoders"

# Fraunhofer encoders on different platforms:
FRAUNHOFER_PATH=$ENCODERS_PATH/mp3sconsv15
FRAUNHOFER=(
  "$FRAUNHOFER_PATH/mp3sEnc_MacOSXuniv_FCRv15_20080530/mp3sEncoder" # macOS
)
if [[ ! -z ${FRAUNHOFER[$PLATFORM]} ]]; then
  encoder=${FRAUNHOFER[$PLATFORM]}
  print_hint "FRAUNHOFER encoder is available on this platform."
  print_hint "You can run '$encoder -h' to know how to use it."
  echo ""
  COMMANDS+=("$encoder -m 0 -q 1 -br 256000 -if $IN_FILE -of ${OUT_FILE}_cbr_fraunhofer.mp3")
  COMMANDS+=("$encoder -m 1 -q 1 -br 0 -if $IN_FILE -of ${OUT_FILE}_vbr_fraunhofer.mp3")
  COMMANDS+=("$encoder -m 1 -q 1 -br 0 -vbri -if $IN_FILE -of ${OUT_FILE}_vbr_vbri_fraunhofer.mp3")
fi

# Check if FFmpeg works on this platform
FFMPEG="ffmpeg"
if [ $(command_exists $FFMPEG) -eq 1 ]; then
  print_hint "$FFMPEG is available on this platform."
  print_hint "You can run '$FFMPEG -h' to know how to use it."
  echo ""
  COMMANDS+=("$FFMPEG -i $IN_FILE -codec:a libmp3lame -b:a 256k ${OUT_FILE}_cbr_xing_libmp3lame.mp3")
  COMMANDS+=("$FFMPEG -i $IN_FILE -codec:a libmp3lame -qscale:a 2 ${OUT_FILE}_vbr_xing_libmp3lame.mp3")
fi

if [ ${#COMMANDS[@]} -eq 0 ]; then
    print_error "No available encoder on this platform. Finish."
    exit
fi

# Convert source files into mp3 files.
# /////////////////////////////////////////////////////////////////////////////
print_title "\nConvert files into mp3"

# Create a folder for output files.
OUTPUT_PATH="mp3"
rm -rf $OUTPUT_PATH
mkdir -p $OUTPUT_PATH

for file in ${SOURCES[@]}; do
  # Remove the extenstion and path in the file to get the filename
  filename="${file##*/}"
  filename="${filename%.*}"
  out_file="$OUTPUT_PATH/$filename"

  # Run commands
  for ((i = 0; i < ${#COMMANDS[@]}; i++)); do
    # Replace $IN_FILE and $OUT_FILE by the input file name and output file name.
    # Both of the file names include their relative paths.
    cmd="${COMMANDS[$i]}"
    cmd="${cmd/$IN_FILE/$file}"
    cmd="${cmd/$OUT_FILE/$out_file}"
    echo ""
    print_hint "Run: $cmd"
    eval $cmd
  done
done