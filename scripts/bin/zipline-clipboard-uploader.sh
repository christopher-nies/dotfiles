#!/bin/bash

source ~/.env

TOKEN=$ZIPLINE_API_KEY  # Replace with your actual token
URL=$ZIPLINE_API_URL  # Replace with your upload URL

# Create a temporary file to store the clipboard image
tmpfile=$(mktemp)

# Detect exact image mime type from clipboard
img_type=$(wl-paste --list-types | grep -m1 'image/')
if [[ -z $img_type ]]; then
    notify-send "Error" "No image in clipboard."
    exit 1
fi

# Use wl-paste to grab the image from clipboard and save it to a temporary file
wl-paste --type "$img_type" > "$tmpfile"

# Check if the image was successfully saved
if [[ ! -s $tmpfile ]]; then
    notify-send "Error" "Failed to get image from clipboard."
    exit 1
fi

# Upload the image using curl
# HINT: 'x-zipline-image-compression-percent: 80, converts image to `jpeg`!
response=$(curl -s -H "authorization: $TOKEN" "$URL" \
    -F "file=@$tmpfile;type=$img_type" \
    -H 'content-type: multipart/form-data' \
    -H 'x-zipline-format: random')

uploaded_url=$(echo "$response" | jq -r '.files[0].url // empty')

# Check if upload was successful
if [[ -z $uploaded_url ]]; then
    notify-send "Upload Failed" "Response: $response"
    exit 1
fi

# Copy the uploaded URL to clipboard
echo -n "$uploaded_url" | wl-copy

# Clean up the temporary file
rm "$tmpfile"

notify-send "Upload Successful" "Uploaded URL copied to clipboard:\n$uploaded_url"
