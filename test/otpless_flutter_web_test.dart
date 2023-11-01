import 'package:flutter_test/flutter_test.dart';
import 'package:otpless_flutter_web/otpless_flutter_web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:js' as js;

void main() {
  if (kIsWeb) {
    test('openLoginPage function is called successfully on web platform',
        () async {
      Otpless otpless = Otpless();
      bool isCalled = false;
      js.context['openLoginPage'] = () {
        isCalled = true;
      };
      await otpless.openLoginPage();
      expect(isCalled, true);
    });
  }
}
