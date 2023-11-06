library otpless_flutter_web;

import 'dart:async';
import 'dart:js' as js;
import 'package:flutter/foundation.dart';

class Otpless {
  /*
    triggers the openLoginPage function which will open the login page from javascript 
  */
  Future<dynamic> openLoginPage() async {
    if (kIsWeb) {
      final completer = Completer<dynamic>();

      js.context.callMethod("openLoginPage", []);

      // Define the Dart function
      callDartFunction(String? message) {
        if (message != null) {
          completer.complete(message);
        } else {
          completer.completeError("Message is null");
        }
      }

      // Assign the Dart function to the JavaScript context
      js.context['callDartFunction'] = callDartFunction;

      // Return the Future that will be completed when message is not null
      return completer.future;
    }

    // Return a Future that's already completed (in this case, you may want to return a different value or null)
    return Future.value(null);
  }
}
