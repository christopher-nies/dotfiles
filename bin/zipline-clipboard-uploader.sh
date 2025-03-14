#!/bin/bash
# Script to upload image content from clipboard to zipfile
source ~/.env
# Get the clipboard content
IMAGE=$(wl-paste)
TOKEN=$ZIPLINE_API_KEY
URL=$ZIPLINE_API_URL

# Now upload the temporary file using curl
curl -H "authorization: $TOKEN" $URL \
    -F file=@"$IMAGE" \
    -H "Content-Type: multipart/form-data" \
    -H x-zipline-image-compression-percent: 80 \
    -H x-zipline-original-name: true \
    -H x-zipline-format: uuid |
    jq -r .files[0].url |
    tr -d '\n' |
    wl-copy


# Send notification
notify-send "file uploaded"
