import 'package:flutter/material.dart';
import 'package:flutter_application_1/authentication/mobile_otp.dart';
import 'package:flutter_application_1/authentication/reset_password.dart';
import 'package:flutter_application_1/authentication/sign_up.dart';
import 'package:flutter_application_1/home.dart';




import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailAddress = TextEditingController();

  TextEditingController password = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  // final TextEditingController _usernameController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  bool _isDataMatched = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Image.asset('asset/images/output-onlinegiftools (1).gif'),
              TextFormField(
                controller: emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    labelText: 'Email Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Value is Empty';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Value is Empty';
                  } else {
                    return null;
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 240),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => resetPassword()),
                      );
                    },
                    child: Text('Forgot Password?')),
              ),
              Row(
                children: [
                  Visibility(
                    visible: !_isDataMatched,
                    child: Text(
                      'Username password doesnot match',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // if (_formKey.currentState!.validate()) {

                      // } else {
                      //   print('Data empty');
                      // }
                      try {
                        final newuser = await auth.signInWithEmailAndPassword(
                            email: emailAddress.text,
                            password: password.text);
                        // ignore: unnecessary_null_comparison
                        if (newuser != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
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
                          backgroundColor: Colors.red,
                          margin: EdgeInsets.all(10),
                        ));
                      }
                    },
                    child: Text('Login'),
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(381, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            30), // Adjust the radius to change the shape
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        fixedSize: Size(50, 50), // Adjust the size as needed
                        // Add other styles if needed (e.g., backgroundColor, padding, etc.)
                        primary: const Color.fromARGB(255, 240, 239, 239),
                      ),
                      onPressed: () async {
                        GoogleSignInAuthenticationLogin();
                      },
                      child: Image.asset(
                        "asset/images/download.png",
                        fit: BoxFit.cover,
                      ) // Replace with your button content
                      ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        fixedSize: Size(50, 50), // Adjust the size as needed
                        // Add other styles if needed (e.g., backgroundColor, padding, etc.)
                        primary: const Color.fromARGB(255, 240, 239, 239),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => mobileOtp()),
                        );
                      },
                      child: Image.asset(
                        "asset/images/download (2).png",
                        fit: BoxFit.cover,
                      ) // Replace with your button content
                      ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => signUp()),
                        );
                      },
                      child: Text('Sign Up Now'))
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }

  // Future<void> checkLogin(BuildContext ctx) async {
  //   // final _username = _usernameController.text;
  //   // final _password = _usernameController.text;
  //   if (_usernameController.text == 'shadh' &&
  //       _passwordController.text == 'shadh') {
  //     print('Username password is match');

  //     final _sharedprfs = await SharedPreferences.getInstance();
  //     await _sharedprfs.setBool(SAVE_KEY_NAME, true);
  //     //go to screen1
  //     Navigator.of(ctx)
  //         .pushReplacement(MaterialPageRoute(builder: (ctx) => Screen1()));
  //   } else
  //     showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //               actions: [
  //                 TextButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: Text("close"),
  //                 )
  //               ],
  //               title: Text(
  //                 "Mis match",
  //                 style: TextStyle(color: Colors.red),
  //               ),
  //               content: Text("You may enterd wrong password or user ID"),
  //             ));
  // }

  Future<void> GoogleSignInAuthenticationLogin() async {
    UserCredential? userCredential = await signInWithGoogle();
    if (userCredential != true) {
      // Successful sign-in
      print("User signed in: ${userCredential.user!.displayName}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      // Sign-in failed msp
      print("Failed to sign in with Google");
    }
    // Add your onPressed logic here
  }
}

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
