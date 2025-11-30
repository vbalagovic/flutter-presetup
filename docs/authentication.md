# Authentication

#### Firebase login

* Riverpod with go router is added to listen for changes in auth state
* Anonymous login works by default when you enable it on firebase with this code
* Social Login updates are coming

**Google social login**

Social login with google has been implemented as an example. You need to add a google login to your firebase auth and then run this script. It'll ask for a Google Reversed Id to update ios data per environment.

```
sh setup_google_login.sh
```

**Facebook social login**

Social login with Facebook has been implemented as an example. You need to add a Facebook login to your firebase auth and then run this script. It'll ask for an app id, token(secret), and app name. The package that was used is [https://facebook.meedu.app/docs/5.x.x/intro](https://facebook.meedu.app/docs/5.x.x/intro) but no implementation to code should be done. Just create a Facebook app for credentials.

```
sh setup_facebook_login.sh
```

**Apple social login**

Apple social login for iOS should work when you set up your Firebase (enable apple signup) and add "Sign in with apple capabilities" on your apple developer account to this identifier. Update the provision file or just open Xcode and recheck automatic provisioning if it's not working.

***

###

\
