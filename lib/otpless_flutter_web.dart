library otpless_flutter_web;

import 'dart:js' as js;
import 'package:flutter/foundation.dart';

class Otpless {
  /*
    triggers the openLoginPage function which will open the login page from javascript 
  */
  Future<void> openLoginPage() async {
    if (kIsWeb) {
      await js.context.callMethod("openLoginPage", []);
      js.context['callDartFunction'] = callDartFunction;
    }
  }

  /*
    This function is called from the javascript to send the data to dart 
  */
  callDartFunction(String message) {
    return message;
  }
}
