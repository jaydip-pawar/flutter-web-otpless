<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Flutter

Integrating One Tap OTPLESS Sign In into your Flutter Website using our SDK is a streamlined process. This guide offers a comprehensive walkthrough, detailing the steps to install the SDK and seamlessly retrieve user information.

1. Install **OTPless SDK** Dependency

```
flutter pub add otpless_flutter_web:1.2.4
```

2. Initialize Otpless in index.html

```html
<!-- Add this script to initiate otpless -->
<script
  data-appid="{YOUR_APP_ID}"
  src="https://otpless.com/v2/flutter.js"
  id="otpless-sdk"
  type="text/javascript"
  variant="HEADLESS"
></script>
```

3. Configure **Sign up/Sign in**

- Import the following classes.

```dart
import 'package:otpless_flutter_web/otpless_flutter_web.dart';
```

- Add this code to your initState() method

```dart
@override
  void initState() {
    _otplessFlutterPlugin.headlessResponse().then((value) {
      print("responseData : $value");
    });
    super.initState();
}
```

- Add this code for OAUTH Authentication

```dart
void initiateOAuth(String channelType) async {
    await _otplessFlutterPlugin.initiateOAuth(channelType).then((value) {
      print("initiateOAuth : $value");
    });
}
```

- Add this code for PHONE/EMAIL Authentication

```dart
void initiatePhoneEmailAuth() async {
    Map<String, dynamic> arg = {};
    if (otpContoller.text.isNotEmpty) {
      if (phoneNumberContoller.text.isNotEmpty) {
        arg["phone"] = phoneNumberContoller.text;
        arg["countryCode"] = "ADD_COUNTRY_CODE";
      } else {
        arg["email"] = emailContoller.text;
      }

      arg["otp"] = otpContoller.text;

      await _otplessFlutterPlugin.verifyAuth(arg).then((value) {
        print("verifyAuth : $value");
      });
    } else {
      if (phoneNumberContoller.text.isNotEmpty) {
        arg["phone"] = phoneNumberContoller.text;
        arg["countryCode"] = "ADD_COUNTRY_CODE";

        await _otplessFlutterPlugin.initiatePhoneAuth(arg).then((value) {
          print("initiatePhoneAuth : $value");
        });
      } else if (emailContoller.text.isNotEmpty) {
        arg["email"] = emailContoller.text;

        await _otplessFlutterPlugin.initiateEmailAuth(arg).then((value) {
          print("initiateEmailAuth : $value");
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter phone number or email"),
        ),
      );
    }
  }
}
```

# Thank You

# [Visit OTPless](https://otpless.com/platforms/flutter)
