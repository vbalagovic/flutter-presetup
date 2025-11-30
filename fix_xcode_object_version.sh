#!/bin/bash

# Script to fix Xcode project objectVersion from 70 back to 54
# This fixes the "Unable to find compatibility version string for object version 70" error

PROJECT_FILE="ios/Runner.xcodeproj/project.pbxproj"

if [ ! -f "$PROJECT_FILE" ]; then
    echo "Error: $PROJECT_FILE not found!"
    exit 1
fi

# Check if objectVersion is 70
if grep -q "objectVersion = 70;" "$PROJECT_FILE"; then
    echo "Found objectVersion = 70, fixing to objectVersion = 54..."

    # Create backup
    cp "$PROJECT_FILE" "$PROJECT_FILE.backup"
    echo "Created backup: $PROJECT_FILE.backup"

    # Replace objectVersion 70 with 54
    sed -i '' 's/objectVersion = 70;/objectVersion = 54;/g' "$PROJECT_FILE"

    echo "✅ Fixed: objectVersion changed from 70 to 54"
    echo "You can now run 'pod install' or other Xcode operations"
else
    echo "objectVersion is not 70. Current version:"
    grep "objectVersion" "$PROJECT_FILE"
fi
