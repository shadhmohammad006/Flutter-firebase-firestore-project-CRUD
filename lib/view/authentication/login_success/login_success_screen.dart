import 'package:flutter/material.dart';
import 'package:flutter_application_1/init_screen.dart';

class LoginSuccessScreen extends StatelessWidget {
  static String routeName = "/login_success";

  const LoginSuccessScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("Login Success"),
      ),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          Image.asset(
            "assets/images/success.png",
            height: MediaQuery.of(context).size.height * 0.4, //40%
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          const Text(
            "Login Success",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, InitScreen.routeName);
              },
              child: const Text("Back to home"),
            ),
          ),
          // const Spacer(),
          SizedBox(
            height: MediaQuery.of(context).size.height / 40,
          )
        ],
      ),
    );
  }
}
