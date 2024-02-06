import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/view/splash/welcome.dart';
import 'package:flutter_application_1/view/splash/splash1.dart';
import 'package:flutter_application_1/viewmodel/cartprovider.dart';
import 'package:flutter_application_1/viewmodel/searchprovider.dart';
import 'package:flutter_application_1/viewmodel/wishlistprovider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'routes.dart';
import 'theme.dart';
import 'viewmodel/apicallprovider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // A future representing the initialization task (e.g., loading data).
  // Future<void> initializeApp() async {
  //   // Simulate some async initialization task.
  //   await Future.delayed(Duration(seconds: 2));
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApiCallProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) =>SearchProvider()),
       ChangeNotifierProvider(create: (_)=>WishListProvider())
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme:AppTheme.lightTheme(context), 
          initialRoute: Splash1.routeName,
      routes: routes,
          // FutureBuilder(
          //     future: initializeApp(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return
          
          //       } else {
          //         return Scaffold(
          //           body: Center(
          //             child: CircularProgressIndicator(),
          //           ),
          //         );
          //       }
          //     },
          //     ),
              ),
    );
  }
}
