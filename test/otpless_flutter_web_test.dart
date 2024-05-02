import 'package:flutter_test/flutter_test.dart';
import 'package:otpless_flutter_web/otpless_flutter_web.dart';

void main() {
  group('Otpless', () {
    late Otpless otpless;

    setUp(() {
      otpless = Otpless();
    });

    test('headlessResponse', () async {
      await otpless.headlessResponse();
      // Add your assertions here
    });

    test('initiateOAuth', () async {
      await otpless.initiateOAuth('channelType');
      // Add your assertions here
    });

    test('initiatePhoneAuth', () async {
      final request = {"key": "value"};
      await otpless.initiatePhoneAuth(request);
      // Add your assertions here
    });

    test('initiateEmailAuth', () async {
      final request = {"key": "value"};
      await otpless.initiateEmailAuth(request);
      // Add your assertions here
    });

    test('verifyAuth', () async {
      final data = {"key": "value"};
      await otpless.verifyAuth(data);
      // Add your assertions here
    });

    test('getCodeForParams', () {
      otpless.getCodeForParams();
      // Add your assertions here
    });

    test('executeFunction', () async {
      await otpless.executeFunction('functionName', []);
      // Add your assertions here
    });
  });
}
