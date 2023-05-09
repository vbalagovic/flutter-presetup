#!/bin/bash
# Ask the user for their name
echo "Lets replace app name an bundleId!"

echo "What is your app desired package name (format eg. flutter_app_1)?"
read packageName

echo "What is your desired bundleId (format eg. com.example.name)?"
read bundleId

echo "What is your app desired name?"
read appName

echo ====================================
echo ==========    RENAMING    ==========
echo ====================================

#fvm flutter pub global activate rename
#fvm flutter pub global run rename --bundleId $bundleId
#fvm flutter pub global run rename --appname $appName

# You can always use search an replace in text editor if this is not working on your machine

grep --exclude=./rename.sh -r -l "FlutterPresetup" . | sort | uniq | xargs perl -e "s/FlutterPresetup/$appName/" -pi

grep --exclude=./rename.sh -r -l "com.example.presetup.dev" . | sort | uniq | xargs perl -e "s/com.example.presetup.dev/$bundleId.dev/" -pi

grep --exclude=./rename.sh -r -l "com.example.presetup" . | sort | uniq | xargs perl -e "s/com.example.presetup/$bundleId/" -pi

grep --exclude=./rename.sh -r -l "presetup" . | sort | uniq | xargs perl -e "s/presetup/$packageName/" -pi

grep --exclude=./rename.sh -r -l "com.example.$packageName.dev" . | sort | uniq | xargs perl -e "s/com.example.$packageName.dev/$bundleId.dev/" -pi

grep --exclude=./rename.sh -r -l "com.example.$packageName" . | sort | uniq | xargs perl -e "s/com.example.$packageName/$bundleId/" -pi

fvm flutter pub run change_app_package_name:main $bundleId

find . -depth -name "presetup.iml" -exec sh -c 'f="{}"; mv -- "$f" "$packageName.iml"' \;
find . -depth -name "presetup_android.iml" -exec sh -c 'f="{}"; mv -- "$f" "$packageName_android.iml"' \;

pth=""
for i in $(find . -depth -name "MainActivity.kt");
do
    pth=${i%/*}
done
npth=""
for j in $(find . -depth -name "ListTileNativeAdFactory.kt");
do
    npth=$j
done

mv $npth $pth

fvm flutter clean

echo "All done!"