import 'package:flutter/material.dart';
import 'package:otpless_flutter_web/otpless_flutter_web.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;
  String? number;

  //Define the instance
  final _otplessFlutterPlugin = Otpless();

  //************************************************************************* */
  //This function will run the floater in the app which contains the WhatsApp button for Authentication
  //************************************************************************* */

  void otplessLoginPage() async {
    await _otplessFlutterPlugin.openLoginPage().then((value) {
      final data = value;
      name = data["data"]["mobile"]["name"];
      number = data["data"]["mobile"]["number"];
      setState(() {});
    });
  }

  @override
  void initState() {
    if (_otplessFlutterPlugin.getCodeForParams() != null) {
      otplessLoginPage();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          otplessLoginPage();
        },
        child: const Text(
          "Login",
        ),
      ),
      body: Center(
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
              "Number : $number",
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
