import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/add.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/update.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
       options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(BloodDonationApp());
}

class BloodDonationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Donation App',
      routes: {'/': (context) => HomePage(),
       '/add': (context) => AddUser(),
       '/update':(context) =>updateUser() },
      initialRoute: '/',
    );
  }
}
