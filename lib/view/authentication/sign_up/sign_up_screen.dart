import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/init_screen.dart';
import 'package:flutter_application_1/view/authentication/login_success/login_success_screen.dart';
import 'package:flutter_application_1/view/authentication/mobile_otp.dart';
import 'package:flutter_application_1/viewmodel/authcontroller.dart';
import 'package:flutter_application_1/viewmodel/cartprovider.dart';
import 'package:get/get.dart';

import '../../../components/socal_card.dart';
import '../../../constants.dart';
import 'components/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = "/sign_up";

  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final getx = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Up",
          style: Theme.of(context).textTheme.titleLarge,
        ),
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
                  const Text("Create New Account", style: headingStyle),
                  // const Text(
                  //   "Complete your details or continue \nwith social media",
                  //   textAlign: TextAlign.center,
                  // ),
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  const SignUpForm(),
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
                            createFieldinFirebase();
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
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  // Text(
                  //   'By continuing your confirm that you agree \nwith our Term and Condition',
                  //   textAlign: TextAlign.center,
                  //   style: Theme.of(context).textTheme.bodySmall,
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
