// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/authentication/login.dart';
// import 'package:flutter_application_1/home.dart';

// // Optional: For loading animation

// // ignore: must_be_immutable
// class SplashScreen extends StatefulWidget {

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//    void initState() {
//     checkGoogleLogOrNot();
//    // checkUserLoggedIn();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Timer(Duration(seconds: 6), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomeScreen()),
//         // SplashScreen()), // Navigate to your main content screen
//       );
//     });

//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // Your logo or branding elements here

//             Image.asset('asset/images/output-onlinegiftools.gif'
//                 ), // Example: Load an image
//             SizedBox(height: 82),
//             Container(
//                 // color: Colors.white,
//                 height: 60,
//                 width: 60,
//                 child: Image.asset(
//                  'asset/images/download (1).png'
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
//     Future<void> checkGoogleLogOrNot() async {
//     UserCredential? userCredential = await signInWithGoogle();
//     if (userCredential != true) {
//       // Successful sign-in
//       // ignore: avoid_print
//       print("User signed in: ${userCredential.user!.displayName}");
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomeScreen(),
//         ),
//       );
//     } else {
//       // Sign-in failed msp
//       print("Failed to sign in with Google");
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => LoginScreen(),
//         ),
//       );
//     }
//   }
// }


