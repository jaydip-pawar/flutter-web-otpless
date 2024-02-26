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

In your `index.html` file, add the following code:

```html
<div id="otpless-login-page">
  <script src="https://otpless.com/flutter.js"></script>
</div>
```

In your `pubspec.yaml` file, add the following dependency:

```yaml
dependencies:
  otpless_flutter_web: ^1.0.10
```

In your `SignIn/SignUp` dart file, add the following code:

```dart
import 'package:otpless_flutter_web/otpless_flutter_web.dart';
final _otplessFlutterPlugin = Otpless();

void otplessLoginPage()async{
  await _otplessFlutterPlugin.openLoginPage().then((value){
    final data = value.toString();
  });
}

//In initState() add the given code
if(_otplessFlutterPlugin.getCodeForParams() != null){
  otplessLoginPage();
}

//To you on tap function
onTap : (){
  otplessLoginPage();
}
```
