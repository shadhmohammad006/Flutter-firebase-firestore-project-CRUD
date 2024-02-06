import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/view/authentication/forgot_password/forgot_password_screen.dart';
import 'package:flutter_application_1/view/authentication/login_success/login_success_screen.dart';
import 'package:flutter_application_1/view/authentication/sign_in/sign_in_screen.dart';
import 'package:flutter_application_1/view/authentication/sign_up/sign_up_screen.dart';
import 'package:flutter_application_1/view/cart/cart_screen.dart';
import 'package:flutter_application_1/view/splash/splash1.dart';

import 'init_screen.dart';
import 'view/home/home_screen.dart';
import 'view/products/products_screen.dart';
import 'view/profile/profile_screen.dart';
import 'view/splash/welcome.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  InitScreen.routeName: (context) => const InitScreen(),
//  WelcomeScreen.routeName: (context) => WelcomeScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  // CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  // OtpScreen.routeName: (context) => const OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProductsScreen.routeName: (context) => ProductsScreen(),
  //DetailsScreen.routeName: (context) => const DetailsScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  Splash1.routeName: (context) => Splash1(),
};
