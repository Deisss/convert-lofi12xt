#!/bin/bash

input_folder=""
output_folder=""
sample_rate=24000

while getopts ":i:o:r:" opt; do
    case $opt in
        i) input_folder="$OPTARG"
        ;;
        o) output_folder="$OPTARG"
        ;;
        r) sample_rate="$OPTARG"
        ;;
        \?) echo "Invalid option -$OPTARG" >&2
        ;;
    esac
done

if [ -z "$input_folder" ] || [ -z "$output_folder" ]; then
    echo "Input and output folders are required"
    exit 1
fi

mkdir -p "$output_folder"

IFS=$'\n' # Set internal field separator to newline
audio_files=($(find "$input_folder" -type f \( -name "*.mp3" -o -name "*.wav" -o -name "*.flac" -o -name "*.aac" -o -name "*.ogg" -o -name "*.aif" \)))
total_files=${#audio_files[@]}

counter=0
for input_file in "${audio_files[@]}"; do
    ((counter++))
    relative_path="${input_file#$input_folder/}"
    output_file="$output_folder/$relative_path"
    output_dir=$(dirname "$output_file")

    mkdir -p "$output_dir"

    # Determine the output file extension
    case "$input_file" in
        *.aif) output_ext=".aif" ;;
        *) output_ext=".wav" ;;
    esac

    output_file="${output_file%.*}$output_ext"

    echo "Doing sample $counter/$total_files"
    ffmpeg -i "$input_file" -ac 1 -ar $sample_rate -hide_banner -loglevel error "$output_file" || echo "Error processing $input_file"
done
