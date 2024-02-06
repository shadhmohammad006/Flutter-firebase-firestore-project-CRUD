import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/usermodel.dart';
import 'package:flutter_application_1/init_screen.dart';
import 'package:flutter_application_1/view/authentication/login_success/login_success_screen.dart';
import 'package:flutter_application_1/view/authentication/sign_in/sign_in_screen.dart';
import 'package:flutter_application_1/view/products/products_screen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../view/authentication/login.dart';
import '../view/authentication/mobile_otp.dart';

class AuthController extends GetxController {
  // step 1 create instance
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController loginpassword = TextEditingController();
  TextEditingController resetemail = TextEditingController();
  TextEditingController loginemailAddress = TextEditingController();

  var loading = false.obs;

  // step 2 create functions

  // create Account with email and password
  signUp() async {
    try {
      loading.value = true;
      await auth.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      // await addUser();
      await verifyEmail();
      Get.to(() => InitScreen());
      loading.value = false;
    } catch (e) {
      Get.snackbar("error", "$e");
      loading.value = false;
    }
  }

  // add user to database
  addUser() async {
    UserModel user =
        UserModel(username: username.text, email: auth.currentUser?.email);
    await db
        .collection("fligo")
        .doc(auth.currentUser?.uid)
        .collection("profile")
        .add(user.toMap());
  }

  // signout
  // signout() async {
  //   await auth.signOut();
  // }

  // signin
  signin(context) async {
    try {
      final newuser = await auth.signInWithEmailAndPassword(
          email: loginemailAddress.text, password: loginpassword.text);
      // ignore: unnecessary_null_comparison
      if (newuser != null) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => LoginSuccessScreen()),
        );
      } else {
        print('error');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Invalid username or password',
          style: TextStyle(fontSize: 17),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black,
        margin: EdgeInsets.all(10),
      ));
    }
  }

  // verifyemail
  verifyEmail() async {
    await auth.currentUser?.sendEmailVerification();
    Get.snackbar("email", "send");
  }

//   Future<void> GoogleSignInAuthenticationLogin(context) async {
//     UserCredential? userCredential = await signInWithGoogle();
//     if (userCredential != true) {
//       // Successful sign-in
//       print("User signed in: ${userCredential.user!.displayName}");
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => BottomNavBar(),
//         ),
//       );
//     } else {
//       // Sign-in failed msp
//       print("Failed to sign in with Google");
//     }
//     // Add your onPressed logic here
//   }
//   Future<UserCredential> signInWithGoogle() async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication? googleAuth =
//       await googleUser?.authentication;

//   // Create a new credential
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );

//   // Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }

// google sign in

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // signout
  SignOut(context) {
    auth.signOut();
    GoogleSignIn().signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
        (route) => false);
  }

  // mobile verification

  final userNumber = TextEditingController();
  void verifyUserPhoneNumber() {
    auth.verifyPhoneNumber(
      phoneNumber: userNumber.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then(
              (value) => print('Logged In Successfully'),
            );
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        receivedID = verificationId;
        otpFieldVisibility = true;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('TimeOut');
      },
    );
    //  notifyListeners();
  }

  Future<void> verifyOTPCode(context) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: receivedID,
      smsCode: otpController.text,
    );
    await auth.signInWithCredential(credential).then((value) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => LoginSuccessScreen()));
      print('User Login In Successful');
    });
    //notifyListeners();
  }

  var receivedID = '';
}
