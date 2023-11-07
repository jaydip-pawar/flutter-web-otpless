library otpless_flutter_web;

import 'dart:async';
import 'dart:html';
import 'dart:js' as js;
import 'package:flutter/foundation.dart';

class Otpless {
  Otpless() {
    getCodeForParams();
  }
  Future<dynamic> openLoginPage() async {
    if (kIsWeb) {
      final completer = Completer<dynamic>();

      js.context.callMethod("openLoginPage", []);

      // Define the Dart function
      callDartFunction(String? message) {
        if (message != null) {
          print("hello $message");
          completer.complete(message);
          print("completer is initizalized");
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

  String? getCodeForParams() {
    // Get the current URL
    final currentUrl = window.location.href;

    // Parse the URL using Uri
    final uri = Uri.parse(currentUrl);

    // Access query parameters
    final queryParams = uri.queryParameters;

    // Example: Get the value of a specific query parameter
    final myQueryParam = queryParams["code"];
    if (myQueryParam != null) {
      openLoginPage();
    }
    return myQueryParam;
  }
}
