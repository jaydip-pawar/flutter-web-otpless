/// A library for interacting with OTP-less authentication on web platforms.
///
/// This library provides classes and functions for initiating and verifying OTP-less authentication
/// methods such as OAuth, phone authentication, and email authentication on web platforms using JavaScript
/// interop.
library otplessflutter_web;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js' as js;

import 'package:flutter/foundation.dart';

/// A class for handling OTP-less authentication operations.
class Otpless {
  /// Calls the HeadlessResponse function to send the SNA data
  ///
  /// Returns a Future with the headless response.
  Otpless() {
    if (getCodeForParams() != null) {
      headlessResponse();
    }
  }

  /// Opens the login page for OTP-less authentication.
  ///
  /// Returns a Future with the result of opening the login page.
  Future<String?> openLoginPage() {
    return executeFunction("openLoginPage", []);
  }

  /// Initiates a headless authentication response.
  ///
  /// Returns a Future with the headless response.
  Future<String?> headlessResponse() {
    return executeFunction("startHeadless", []);
  }

  /// Initiates OAuth authentication.
  ///
  /// [channelType] - The type of channel to use for authentication.
  /// Returns a Future with the result of initiating OAuth authentication.
  Future<String?> initiateOAuth(String channelType) {
    final data = {"channelType": channelType, "channel": "OAUTH"};
    return executeFunction("initiateAuth", [jsonEncode(data)]);
  }

  /// Initiates phone number authentication.
  ///
  /// [request] - The request data for phone authentication.
  /// Returns a Future with the result of initiating phone authentication.
  Future<String?> initiatePhoneAuth(Map<String, dynamic> request) {
    final data = {...request, "channel": "PHONE"};
    return executeFunction("initiateAuth", [jsonEncode(data)]);
  }

  /// Initiates email authentication.
  ///
  /// [request] - The request data for email authentication.
  /// Returns a Future with the result of initiating email authentication.
  Future<String?> initiateEmailAuth(Map<String, dynamic> request) {
    final data = {...request, "channel": "EMAIL"};
    return executeFunction("initiateAuth", [jsonEncode(data)]);
  }

  /// Verifies the authentication.
  ///
  /// [data] - The authentication data to verify.
  /// Returns a Future with the result of authentication verification.
  Future<String?> verifyAuth(dynamic data) {
    return executeFunction("verifyAuth", [jsonEncode(data)]);
  }

  /// Gets the authentication code from URL parameters.
  ///
  /// Returns the authentication code from URL parameters, if available.
  String? getCodeForParams() {
    final currentUrl = window.location.href.replaceAll("/#", "");
    final uri = Uri.parse(currentUrl);
    return uri.queryParameters['code'];
  }

  /// Executes a JavaScript function asynchronously.
  ///
  /// [functionName] - The name of the JavaScript function to execute.
  /// [arguments] - Optional arguments to pass to the JavaScript function.
  /// Returns a Future with the result of the JavaScript function execution.
  Future<String?> executeFunction(String functionName,
      [List<Object>? arguments]) async {
    if (!kIsWeb) return "null";
    final completer = Completer<String?>();

    js.context.callMethod(functionName, arguments);

    js.context['getResponse'] = (String? message) {
      if (jsonDecode(message!)["responseType"] == "ONETAP") {
        completer.complete(message);
      }
    };
    return completer.future;
  }
}
