library otpless_flutter_web;

///library provides classes for working with asynchronous programming
///
/// allowing you to handle asynchronous operations such as futures and streams
import 'dart:async';

/// This import is for supporting the functionality of [window] command
import 'dart:html';

/// This import is for supporting the functionality of [callMethod] which are used
/// to make call from dart to javascript functions
import 'dart:js' as js;

import 'package:flutter/foundation.dart';

class Otpless {
  ///This function will be used to trigger the OTPless Login page from the javascript code
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

  /// This function is used for fetching the query parameters [code] from the web link
  String? getCodeForParams() {
    // Get the current URL
    final currentUrl = window.location.href;

    String modifiedString = currentUrl.replaceAll("/#", "");
    // Parse the URL using Uri
    final uri = Uri.parse(modifiedString);

    final code = uri.queryParameters['code'];
    return code;
  }
}
