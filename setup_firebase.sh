echo "Setting up firebase"

echo "Enter firebase project name"
read projectName

echo "Enter environment dev/prod (defaults to dev)"
read projectEnv

flutterfire configure --project=$projectName

if [ -z "$projectEnv" ]
then
    projectEnv="dev"
fi

if [ $projectEnv == "dev" ]; then
    rm './android/app/src/dev/google-services.json'
    mv './android/app/google-services.json' './android/app/src/dev/google-services.json'

    mv './ios/firebase_app_id_file.json' './ios/config/dev/firebase_app_id_file.json'
    rm './ios/config/dev/GoogleService-Info.plist'
    mv './ios/Runner/GoogleService-Info.plist' './ios/config/dev/GoogleService-Info.plist'

    rm './lib/firebase_options_dev.dart'
    mv './lib/firebase_options.dart' './lib/firebase_options_dev.dart'
    git restore ios/Runner.xcodeproj/project.pbxproj
fi

if [ $projectEnv == "prod" ]; then
    rm './android/app/src/prod/google-services.json'
    mv './android/app/google-services.json' './android/app/src/prod/google-services.json'

    mv './ios/firebase_app_id_file.json' './ios/config/prod/firebase_app_id_file.json'
    rm './ios/config/prod/GoogleService-Info.plist'
    mv './ios/Runner/GoogleService-Info.plist' './ios/config/prod/GoogleService-Info.plist'

    rm './lib/firebase_options_prod.dart'
    mv './lib/firebase_options.dart' './lib/firebase_options_prod.dart'
    git restore ios/Runner.xcodeproj/project.pbxproj
fi
