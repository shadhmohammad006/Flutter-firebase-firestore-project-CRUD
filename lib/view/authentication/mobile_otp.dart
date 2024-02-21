import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/custom_surfix_icon.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/helper/keyboard.dart';
import 'package:flutter_application_1/viewmodel/authcontroller.dart';
import 'package:get/get.dart';

class MobileOtp extends StatefulWidget {
  const MobileOtp({super.key});

  @override
  State<MobileOtp> createState() => _MobileOtpState();
}

FirebaseAuth auth = FirebaseAuth.instance;
final _formKey = GlobalKey<FormState>();
final getx = Get.put(AuthController());
final otpController = TextEditingController();

class _MobileOtpState extends State<MobileOtp> {
  String? mobilenumber;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Getx = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mobile Otp",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 55,
                  child: TextFormField(
                    controller: Getx.userNumber,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    onSaved: (newValue) => mobilenumber = newValue,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        removeError(error: kEmailNullError);
                      } else if (emailValidatorRegExp.hasMatch(value)) {
                        removeError(error: kInvalidEmailError);
                      }
                      return;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        addError(error: kEmailNullError);
                        return "";
                      } else if (!emailValidatorRegExp.hasMatch(value)) {
                        addError(error: kInvalidEmailError);
                        return "";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Phone",
                      hintText: "eg:+919876543210",
                      // If  you are using latest version of flutter then lable text and hint text shown like this
                      // if you r using flutter less then 1.20.* then maybe this is not working properly
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon:
                          CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
                    ),
                  ),
                  //  TextField(
                  //   controller: Getx.userNumber,
                  //   decoration: InputDecoration(
                  //     hintText: 'eg:+919876543210',
                  //     hintStyle: TextStyle(color: Colors.grey),

                  //     filled: true,
                  //     fillColor: kSecondaryColor.withOpacity(0.1),
                  //   ),
                  // ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // child: Container(
              //   width: 365,
              //   height: 55,
              //    child:
              // ElevatedButton(
              //     style: ButtonStyle(
              //         backgroundColor: MaterialStatePropertyAll(Colors.teal),
              //         shape: MaterialStateProperty.all(
              //           RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(10)),
              //         )),
              //     onPressed: () async {
              //       if (_formKey.currentState!.validate()) {
              //         _formKey.currentState!.save();
              //         // if all are valid then go to success screen
              //         KeyboardUtil.hideKeyboard(context);
              //         Getx.verifyUserPhoneNumber();
              //         Navigator.of(context).pushReplacement(
              //           MaterialPageRoute(builder: (context) => OTP_Page()),
              //         );
              //       }
              //     },
              //     child: Text(
              //       "Send OTP",
              //       style: TextStyle(
              //         fontSize: 17,
              //       ),
              //     )),
              // ),
              child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // if all are valid then go to success screen
                      KeyboardUtil.hideKeyboard(context);

                      // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => LoginSuccessScreen()));
                    }
                  },
                  child: getx.loading.value
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text("Sent Otp")),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class OTP_Page extends StatefulWidget {
  OTP_Page({super.key});

  @override
  State<OTP_Page> createState() => _OTP_PageState();
}

class _OTP_PageState extends State<OTP_Page> {
  @override
  Widget build(BuildContext context) {
    final Getx1 = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 55,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: otpController,
                  decoration: InputDecoration(
                    hintText: 'Enter OTP',
                    hintStyle: TextStyle(color: Colors.white60),
                    filled: true,
                    fillColor: Colors.teal[900],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white70)),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: 365,
              height: 55,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.teal),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {
                    if (otpFieldVisibility) {
                      Getx1.verifyOTPCode(context);
                    } else {
                      Getx1.verifyUserPhoneNumber();
                    }
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

bool otpFieldVisibility = false;
