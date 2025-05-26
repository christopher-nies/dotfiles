#!/bin/bash

source ~/.env

TOKEN=$ZIPLINE_API_KEY  # Replace with your actual token
URL=$ZIPLINE_API_URL  # Replace with your upload URL

# Create a temporary file to store the clipboard image
tmpfile=$(mktemp --suffix=.png)

# Use wl-paste to grab the image from clipboard and save it to a temporary file
wl-paste > "$tmpfile"

# Check if the image was successfully saved
if [[ ! -s $tmpfile ]]; then
    notify-send "Error" "Failed to get image from clipboard."
    exit 1
fi

# Upload the image using curl
uploaded_url=$(curl -H "authorization: $TOKEN" "$URL" \
    -F "file=@$tmpfile" \
    -H 'content-type: multipart/form-data' \
    # compression converts automatically to *.jpg!
    -H 'x-zipline-image-compression-percent: 80' \
    -H 'x-zipline-format: random' | \
    jq -r .files[0].url)

# Check if upload was successful
if [[ -z $uploaded_url ]]; then
    echo "Upload failed or no URL returned."
    exit 1
fi

# Copy the uploaded URL to clipboard
echo -n "$uploaded_url" | wl-copy

# Clean up the temporary file
rm "$tmpfile"

notify-send "Upload Successful" "Uploaded URL copied to clipboard:\n$uploaded_url"
