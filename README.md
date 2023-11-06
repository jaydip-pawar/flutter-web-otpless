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

This package supports the otpless_flutter web support. For more info please [Visit OTPless](https://otpless.com/)

# otpless_flutter_web

## Installation

In your `web` folder, add the custom.js file and add this code:

```js
const OtplessLoginPageVisibility = (visibility) => {
  const OtplessLoginPage = document.getElementById("otpless-login-page");
  OtplessLoginPage.style.display = visibility;
};

const SetOtplessCallback = () => {
  window.otpless = (otplessUser) => {
    console.log(`SetOtplessCallback-${JSON.stringify(otplessUser)}`);
    window.callDartFunction(JSON.stringify(otplessUser));
    OtplessLoginPageVisibility("none");
  };
};

function openLoginPage() {
  SetOtplessCallback();
  const script = document.createElement("script");
  script.type = "text/javascript";
  script.src = "https://otpless.com/auth.js";
  document.head.appendChild(script);
}

const OtplessLoginPageInit = () => {
  const getURLParameter = (paramName, URLString = window.location.href) => {
    const regex = new RegExp("[\\?&]" + paramName + "=([^&#]*)");
    const results = regex.exec(URLString);

    if (results && results.length > 0) {
      return decodeURIComponent(results[1].replace(/\+/g, " "));
    }
    return "";
  };

  if (getURLParameter("code")) {
    console.log(window.location.href);
    openLoginPage("ef0kpz5g");
  }
};

OtplessLoginPageInit();
```

In your `index.html` file, add the following code:

```html
<div id="otpless-login-page">
  <script src="custom.js"></script>
  <script defer src="main.dart.js"></script>
</div>
```

In your `pubspec.yaml` file, add the following dependency:

```yaml
dependencies:
  otpless_flutter_web: ^0.0.2
```

In your `SignIn/SignUp` dart file, add the following code:

```dart
import 'package:otpless_flutter_web/otpless_flutter_web.dart';
final _otplessFlutterPlugin = Otpless();
//To you on tap function
_otplessFlutterPlugin.openLoginPage();
```
