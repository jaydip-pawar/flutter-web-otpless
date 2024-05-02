import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:otpless_flutter_web/otpless_flutter_web.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Otpless Flutter Web Testing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;
  String? data;
  final TextEditingController phoneNumberContoller = TextEditingController();
  final TextEditingController otpContoller = TextEditingController();
  final TextEditingController emailContoller = TextEditingController();
  //Define the instance
  final _otplessFlutterPlugin = Otpless();
  final completer = Completer<String>();
  //************************************************************************* */
  //This function will run the floater in the app which contains the WhatsApp button for Authentication
  //************************************************************************* */

  void initiateOAuth(String channelType) async {
    await _otplessFlutterPlugin.initiateOAuth(channelType).then((value) {
      print("initiateOAuth : $value");
    });
  }

  void initiatePhoneEmailAuth() async {
    Map<String, dynamic> arg = {};
    if (otpContoller.text.isNotEmpty) {
      if (phoneNumberContoller.text.isNotEmpty) {
        arg["phone"] = phoneNumberContoller.text;
        arg["countryCode"] = "91";
      } else {
        arg["email"] = emailContoller.text;
      }

      arg["otp"] = otpContoller.text;

      await _otplessFlutterPlugin.verifyAuth(arg).then((value) {
        print("verifyAuth : $value");
        name = jsonDecode(value!)['response']['identities'][0]['name'];
        data = jsonDecode(value)['response']['identities'][0]['identityValue'];
        setState(() {});
      });
    } else {
      if (phoneNumberContoller.text.isNotEmpty) {
        arg["phone"] = phoneNumberContoller.text;
        arg["countryCode"] = "91";

        await _otplessFlutterPlugin.initiatePhoneAuth(arg).then((value) {
          print("initiatePhoneAuth : $value");
          name = jsonDecode(value!)['response']['identities'][0]['name'];
          data =
              jsonDecode(value)['response']['identities'][0]['identityValue'];
          setState(() {});
        });
      } else if (emailContoller.text.isNotEmpty) {
        arg["email"] = emailContoller.text;

        await _otplessFlutterPlugin.initiateEmailAuth(arg).then((value) {
          print("initiateEmailAuth : $value");
          name = jsonDecode(value!)['response']['identities'][0]['name'];
          data =
              jsonDecode(value)['response']['identities'][0]['identityValue'];
          setState(() {});
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter phone number or email"),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    _otplessFlutterPlugin.headlessResponse().then((value) {
      print("responseData : $value");
      name = jsonDecode(value!)['response']['identities'][0]['name'];
      data = jsonDecode(value)['response']['identities'][0]['identityValue'];
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            children: [
              Text(
                "Name : $name",
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Data : $data",
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
              TextField(
                controller: phoneNumberContoller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Phone number",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailContoller,
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
              ),
              const SizedBox(height: 50),
              TextField(
                controller: otpContoller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "OTP",
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      initiatePhoneEmailAuth();
                    },
                    child: const Text(
                      "PHONE/EMAIL",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      initiateOAuth("GOOGLE");
                    },
                    child: const Text(
                      "OAUTH",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
