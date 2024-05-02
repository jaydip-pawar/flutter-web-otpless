import 'dart:convert';
import 'dart:js' as js;

import 'package:flutter_test/flutter_test.dart';
import 'package:otpless_flutter_web/otpless_flutter_web.dart';

void main() {
  group('Otpless', () {
    late Otpless otpless;

    setUp(() {
      otpless = Otpless();
    });

    test('initiateOAuth should call executeFunction with correct arguments',
        () {
      resultCallback(dynamic result) {}
      const channelType = 'someChannelType';

      otpless.initiateOAuth(resultCallback, channelType);

      final expectedData = {"channelType": channelType, "channel": "OAUTH"};
      final expectedArguments = [jsonEncode(expectedData)];

      expect(js.context['getResponse'], isNotNull);
      expect(js.context['getResponse'], isA<Function>());
    });

    test('initiatePhoneAuth should call executeFunction with correct arguments',
        () {
      resultCallback(dynamic result) {}
      final requestData = {"phoneNumber": "1234567890"};

      otpless.initiatePhoneAuth(resultCallback, requestData);

      final expectedData = {...requestData, "channel": "PHONE"};
      final expectedArguments = [jsonEncode(expectedData)];

      expect(js.context['getResponse'], isNotNull);
      expect(js.context['getResponse'], isA<Function>());
    });

    test('verifyAuth should call executeFunction with correct arguments', () {
      resultCallback(dynamic result) {}
      final requestData = {"someKey": "someValue"};

      otpless.verifyAuth(resultCallback, requestData);

      final expectedArguments = [jsonEncode(requestData)];

      expect(js.context['getResponse'], isNotNull);
      expect(js.context['getResponse'], isA<Function>());
    });
  });
}
