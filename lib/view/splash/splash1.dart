import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/init_screen.dart';
import 'package:flutter_application_1/view/authentication/mobile_otp.dart';
import 'package:flutter_application_1/view/splash/welcome.dart';

class Splash1 extends StatelessWidget {
  static String routeName = "/Splash1";

  const Splash1({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          auth.currentUser?.uid != null
              ? MaterialPageRoute(builder: (context) => InitScreen())
              : MaterialPageRoute(builder: (context) => WelcomeScreen()));
    });
    return Scaffold(
      body: Center(
          child: CircleAvatar(
        radius: 70,
        backgroundColor: Color.fromARGB(255, 251, 250, 255),
        child: Center(
          child: Text(
            "Fligo",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Color.fromARGB(255, 139, 67, 255)),
          ),
        ),
      )),
    );
  }
}
