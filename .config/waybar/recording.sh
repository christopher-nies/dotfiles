#!/bin/bash

# Check if 'parec' is running
if pgrep -x "parec" > /dev/null; then
    echo "true"
fi