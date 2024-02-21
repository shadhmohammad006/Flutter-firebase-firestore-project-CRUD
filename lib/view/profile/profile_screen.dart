import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/authentication/sign_in/components/sign_form.dart';
import 'package:flutter_application_1/view/notification/notification_screen.dart';
import 'package:flutter_application_1/view/order/order_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../viewmodel/authcontroller.dart';
import '../authentication/sign_in/sign_in_screen.dart';
import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  ProfileScreen({super.key});
  final getx = Get.put(AuthController());

  final List<String> options = ['My Orders', 'Logout', 'Delete Account'];

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Text(
              "Profile",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     alignment: Alignment.center,
            //     child: CircleAvatar(
            //       radius: 50,
            //       child: user?.photoURL != null
            //           ? ClipOval(
            //               child: Image.network(
            //                 user!.photoURL!,
            //                 fit: BoxFit.fill,
            //                 width: 100,
            //                 height: 100,
            //               ),
            //             )
            //           : Icon(
            //               Icons.person,
            //               size: 70,
            //             ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //     user?.email ?? 'Guest',
            //     style: TextStyle(fontWeight: FontWeight.bold),
            //   ),
            // ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: options.length,
            //     itemBuilder: (context, index) {
            //       return ListTile(
            //         selectedColor: Colors.amber,
            //         title: Text(options[index]),
            //         onTap: () {
            //           // Handle item tap based on index
            //           switch (index) {
            //             case 0:
            //              // order logic
            //               Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                         builder: (context) => OrderPage(

            //                         ),
            //                       ),
            //                     );

            //               break;
            //             case 1:
            //               // Logout logic
            //               authController.signOut(context);
            //               break;
            //             case 2:
            //              // Delete Account logic
            //               // authController.DeleteAccount(context);
            //               break;

            //             // Add more cases for additional options if needed
            //           }
            //         },
            //       );
            //     },
            //   ),
            // ),
            ProfilePic(),
            const SizedBox(height: 10),
            ProfileMenu(
              text: "My Orders",
              icon: "assets/icons/User Icon.svg",
              press: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderScreen()))
              },
            ),
            ProfileMenu(
              text: "Notifications",
              icon: "assets/icons/Bell.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
            ),
            ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Help Center",
              icon: "assets/icons/Question mark.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () {
                getx.SignOut(context);
                getx.email.clear();
                getx.password.clear();
                getx.loginemailAddress.clear();
                getx.loginpassword.clear();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                    (route) => false);
              },
            ),
            ProfileMenu(
              text: "Delete Account",
              icon: "assets/icons/Trash.svg",
              press: () {},
            )
          ],
        ),
      ),
    );
  }
}
