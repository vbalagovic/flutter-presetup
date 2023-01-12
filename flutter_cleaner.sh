rm -Rf ios/Pods && \
rm -Rf ios/.symlinks && \
rm -Rf ios/Flutter/Flutter.framework && \
rm -Rf ios/Flutter/Flutter.podspec && \
rm -rf ~/.pub-cache && \
fvm flutter pub get && \
cd ios && fvm flutter precache --ios && pod install --repo-update && cd ..