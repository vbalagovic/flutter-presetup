# Push Notifications

#### Integration

For android it is straight forward, but for iOS you need to add Push notifications capability to indentifier and add certificate to firebase: Follow the first few steps on [official documentation](https://firebase.flutter.dev/docs/messaging/apple-integration) if you're not familiar with this. Background modes & push notifications are added (at least should be) in Xcode already.

#### Handle notifications in code

States that are handled in code are in app, background mode and terminated state.

* For handling In app local notifications package is used
* To update anything related to push notification or handle onTap events etc. check `push_notif_service.dart` & `local_notif_service.dart` files
