#!/bin/bash

# Find all .wls files recursively
find . -type f -name "*.wls" | while read -r file; do
    # Use the macOS compatible sed command with an empty string for backup
    sed -i '' 's/(\* ::Chapter:: \*)/(\* ::Chapter::Closed:: \*)/g' "$file"
    sed -i '' 's/(\* ::Title:: \*)/(\* ::Title::Closed:: \*)/g' "$file"
done
