#!/bin/bash

# Specify the directory you want to zip
DIRECTORY_TO_ZIP="/home/chris/Documents/obsidian/vault/"
DESTINATION_DIRECTORY="/home/chris/Downloads/"
# Get the current timestamp in the format YYYYMMDD_HHMMSS
TIMESTAMP=$(date +"%Y-%m-%d_%H%M%S")

# Create the zip filename with the timestamp
ZIP_FILENAME="vault_$TIMESTAMP.zip"

# Move to the parent directory of the specified directory
cd "$(dirname "$DIRECTORY_TO_ZIP")" || exit

# Create the zipped archive
zip -r -q "$ZIP_FILENAME" "$(basename "$DIRECTORY_TO_ZIP")"

mv "$ZIP_FILENAME" "$DESTINATION_DIRECTORY"

# Print a success message
echo "Created zipped archive: $ZIP_FILENAME"
