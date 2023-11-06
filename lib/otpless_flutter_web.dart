library otpless_flutter_web;

import 'dart:js' as js;
import 'package:flutter/foundation.dart';

class Otpless {
  /*
    triggers the openLoginPage function which will open the login page from javascript 
  */
  Future<dynamic> openLoginPage() async {
    if (kIsWeb) {
      String? data;
      await js.context.callMethod("openLoginPage", []);
      js.context['callDartFunction'] = data;
      return data;
    }
  }
}
