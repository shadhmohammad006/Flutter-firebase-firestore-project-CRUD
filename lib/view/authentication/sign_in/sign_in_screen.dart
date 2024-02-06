import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/no_account_text.dart';
import 'package:flutter_application_1/components/socal_card.dart';
import 'package:flutter_application_1/init_screen.dart';
import 'package:flutter_application_1/view/authentication/login_success/login_success_screen.dart';
import 'package:flutter_application_1/view/authentication/mobile_otp.dart';
import 'package:flutter_application_1/viewmodel/authcontroller.dart';
import 'package:get/get.dart';

import 'components/sign_form.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = "/sign_in";

  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final getx = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Sign in with your email and password  \nor continue with social media",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  const SignForm(),
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocalCard(
                        icon: "assets/icons/google-icon.svg",
                        press: () async {
                          UserCredential userCredential =
                              await getx.signInWithGoogle();
                          if (userCredential != true) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LoginSuccessScreen()));
                          } else {}
                        },
                      ),
                      SocalCard(
                        icon: "assets/icons/Phone.svg",
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MobileOtp()));
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 150),
                  const NoAccountText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
