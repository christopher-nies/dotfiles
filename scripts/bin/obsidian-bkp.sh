#!/bin/bash

# Get vault path from Obsidian CLI
DIRECTORY_TO_ZIP=$(obsidian vault info=path 2>/dev/null)

if [ -z "$DIRECTORY_TO_ZIP" ]; then
    echo "Error: Could not get vault path from Obsidian CLI. Is Obsidian running?"
    exit 1
fi

# Prompt user for destination directory
DEFAULT_DESTINATION="$HOME/Downloads/"
read -rp "Destination directory [$DEFAULT_DESTINATION]: " DESTINATION_DIRECTORY
DESTINATION_DIRECTORY="${DESTINATION_DIRECTORY:-$DEFAULT_DESTINATION}"

# Expand ~ if present
DESTINATION_DIRECTORY="${DESTINATION_DIRECTORY/#\~/$HOME}"

if [ ! -d "$DESTINATION_DIRECTORY" ]; then
    echo "Error: Destination directory does not exist: $DESTINATION_DIRECTORY"
    exit 1
fi

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
echo "Created zipped archive: $DESTINATION_DIRECTORY$ZIP_FILENAME"
