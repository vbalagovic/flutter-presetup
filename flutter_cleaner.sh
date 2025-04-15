#!/bin/bash

# Check if fvm is installed
if ! command -v fvm &> /dev/null
then
    echo "fvm is not installed. Please install fvm."
    exit 1
fi

# Deleting iOS build files
echo "Deleting iOS Pods, symlinks, and Flutter framework files..."
rm -Rf ios/Pods
rm -Rf ios/.symlinks
rm -Rf ios/Flutter/Flutter.framework
rm -Rf ios/Flutter/Flutter.podspec
rm -f ios/Podfile.lock
rm -rf ~/Library/Developer/Xcode/DerivedData

# Deleting pub-cache
echo "Deleting ~/.pub-cache..."
rm -rf ~/.pub-cache

# Clean Flutter build files
echo "Cleaning Flutter build..."
fvm flutter clean

# Fetching Flutter dependencies
echo "Fetching Flutter dependencies..."
fvm flutter pub get

# Pre-caching iOS platform resources
echo "Pre-caching Flutter resources for iOS platform..."
cd ios
fvm flutter precache --ios
if [ $? -ne 0 ]; then
    echo "Error during Flutter resource pre-caching for iOS!"
    exit 1
fi

# Installing Pod dependencies
echo "Installing Pod dependencies..."
pod install --repo-update
if [ $? -ne 0 ]; then
    echo "Error during Pod dependencies installation!"
    exit 1
fi

# Returning to the root directory
cd ..

echo "Script completed successfully!"
