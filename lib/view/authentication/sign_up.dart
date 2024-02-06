// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/view/authentication/login.dart';
// import 'package:flutter_application_1/viewmodel/authcontroller.dart';

// import 'package:get/get.dart';

// class signUp extends StatefulWidget {
//   const signUp({super.key});

//   @override
//   State<signUp> createState() => _signUpState();
// }

// class _signUpState extends State<signUp> {
//   TextEditingController dateinput = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//   String name = "";
//   final ctrl = Get.put(AuthController());
//   // TextEditingController emailAddress = TextEditingController();
//   // TextEditingController password = TextEditingController();
//   FirebaseAuth auth = FirebaseAuth.instance;
//   // void initState() {
//   //   dateinput.text = ""; //set the initial value of text field
//   //   super.initState();
//   // }

//   // var selectedGender;

//   // void selectGender(String gender) {
//   //   setState(() {
//   //     selectedGender = gender;
//   //   });
//   // }

//   bool _obscureText = true; // Initially hide the password

//   void _togglePasswordVisibility() {
//     setState(() {
//       _obscureText = !_obscureText;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Image.asset('asset/images/unnamed-removebg-preview.png'),
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(
//                       MaterialPageRoute(builder: (context) => LoginScreen()),
//                     );
//                   },
//                   child: Text('back')),
//               TextFormField(
//                 controller: ctrl.username,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30)),
//                   labelText: 'username',
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               TextFormField(
//                 controller: ctrl.email,
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30)),
//                     labelText: 'email'),
//               ),
//               // SizedBox(height: 20),
//               // TextFormField(
//               //   decoration: InputDecoration(
//               //     labelText: 'Enter Phone Number',
//               //     border: OutlineInputBorder(
//               //         borderRadius: BorderRadius.circular(30)),
//               //   ),
//               // ),

//               SizedBox(
//                 height: 20,
//               ),
//               TextFormField(
//                 controller: ctrl.password,
//                 obscureText: _obscureText,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30)),
//                   labelText: 'password',
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _obscureText ? Icons.visibility : Icons.visibility_off,
//                     ),
//                     onPressed: _togglePasswordVisibility,
//                   ),
//                 ),
//               ),
//               // SizedBox(
//               //   height: 20,
//               // ),
//               // GestureDetector(
//               //   child: TextField(
//               //     controller: dateinput, //editing controller of this TextField
//               //     decoration: InputDecoration(
//               //         border: OutlineInputBorder(
//               //             borderRadius: BorderRadius.circular(30)),
//               //         icon: Icon(Icons.calendar_today),
//               //         labelText: "Enter Date Of Birth" //label text of field
//               //         ),
//               //     readOnly:
//               //         true, //set it true, so that user will not able to edit text
//               //     onTap: () async {
//               //       DateTime? pickedDate = await showDatePicker(
//               //           context: context,
//               //           initialDate: DateTime.now(),
//               //           firstDate: DateTime(
//               //               1900), //DateTime.now() - not to allow to choose before today.
//               //           lastDate: DateTime(2040));

//               //       if (pickedDate != null) {
//               //         print(
//               //             pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
//               //         String formattedDate =
//               //             DateFormat('dd-MM-yyyy').format(pickedDate);
//               //         print(
//               //             formattedDate); //formatted date output using intl package =>  2021-03-16
//               //         //you can implement different kind of Date Format here according to your requirement

//               //         setState(() {
//               //           dateinput.text =
//               //               formattedDate; //set output date to TextField value.
//               //         });
//               //       } else {
//               //         print("Date is not selected");
//               //       }
//               //     },
//               //   ),
//               // ),
//               // SizedBox(
//               //   height: 20,
//               // ),
//               // Text(
//               //   'Selected Gender: ${selectedGender ?? 'None'}',
//               //   style: TextStyle(fontSize: 18),
//               // ),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.center,
//               //   children: [
//               //     ElevatedButton(
//               //       onPressed: () => selectGender('Male'),
//               //       style: ElevatedButton.styleFrom(
//               //         primary: selectedGender == 'Male' ? Colors.blue : null,
//               //       ),
//               //       child: Text('Male'),
//               //     ),
//               //     SizedBox(width: 20),
//               //     ElevatedButton(
//               //       onPressed: () => selectGender('Female'),
//               //       style: ElevatedButton.styleFrom(
//               //         primary: selectedGender == 'Female' ? Colors.blue : null,
//               //       ),
//               //       child: Text('Female'),
//               //     ),
//               //   ],
//               // ),
//               SizedBox(
//                 height: 20,
//               ),
//               Obx(
//                 () => ElevatedButton(
//                   onPressed: () async {
//                     // createAccound();
//                     ctrl.signUp();
//                   },
//                   child: ctrl.loading.value
//                       ? CircularProgressIndicator(
//                           color: Colors.white,
//                         )
//                       : Text('Sign up'),
//                   style: OutlinedButton.styleFrom(
//                     backgroundColor: Colors.teal,
//                     fixedSize: Size(381, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(
//                           30), // Adjust the radius to change the shape
//                     ),
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Already have an account?'),
//                   TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop(
//                           MaterialPageRoute(
//                               builder: (context) => LoginScreen()),
//                         );
//                       },
//                       child: Text('Sign in'))
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Future<void> createAccound() async {
//   //   try {
//   //     final newuser = await auth.createUserWithEmailAndPassword(
//   //         email: emailAddress.text, password: password.text);
//   //     // ignore: unnecessary_null_comparison
//   //     if (newuser != null) {
//   //       Navigator.of(context).pushReplacement(
//   //         MaterialPageRoute(builder: (context) => HomeScreen()),
//   //       );
//   //     } else {
//   //       print('error');
//   //     }
//   //   } catch (e) {
//   //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //       content: Text(
//   //         'Invalid username or password',
//   //         style: TextStyle(fontSize: 17),
//   //       ),
//   //       behavior: SnackBarBehavior.floating,
//   //       backgroundColor: Colors.red,
//   //       margin: EdgeInsets.all(10),
//   //     ));
//   //   }
//   // }
// }
