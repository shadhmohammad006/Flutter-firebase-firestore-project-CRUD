import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model_class.dart';
import 'package:flutter_application_1/view/cart/cart_screen.dart';
import 'package:flutter_application_1/view/home/home_screen.dart';
import 'package:flutter_application_1/view/notification/notification_screen.dart';
import 'package:flutter_application_1/view/products/products_screen.dart';
import 'package:flutter_application_1/view/profile/profile_screen.dart';
import 'package:flutter_application_1/view/favorite/favorite_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'constants.dart';
import 'view/search/search.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});
  static String routeName = "/";

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
// //  var _currentIndex = 0;
//   int _selectedIndex = 0;

//   static List<Widget> _screens = [
//     HomeScreen(),
//     SearchScreen(),
//     WishList(),
//     addCart(),
//     ProfilePage()
//   ];
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
  int currentSelectedIndex = 0;

  void updateCurrentIndex(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
  }

  final pages = [
    HomeScreen(),
    const FavoriteScreen(),
    const NotificationScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(child: _screens.elementAt(_selectedIndex)),
      // bottomNavigationBar: SalomonBottomBar(
      //   items: [
      //     /// Home
      //     SalomonBottomBarItem(
      //       icon: Icon(Icons.home),
      //       title: Text("Home"),
      //       selectedColor: Colors.teal,
      //     ),

      //     /// Likes
      //     SalomonBottomBarItem(
      //       icon: Icon(Icons.search),
      //       title: Text("Search"),
      //       selectedColor: Colors.teal,
      //     ),

      //     /// Search
      //     SalomonBottomBarItem(
      //       icon: Icon(Icons.favorite_border),
      //       title: Text("Favorite"),
      //       selectedColor: Colors.teal,
      //     ),

      //     /// cart
      //     SalomonBottomBarItem(
      //       icon: Icon(Icons.shopping_cart),
      //       title: Text("Cart"),
      //       selectedColor: Colors.teal,
      //     ),

      //     /// Profile
      //     SalomonBottomBarItem(
      //       icon: Icon(Icons.person),
      //       title: Text("Profile"),
      //       selectedColor: Colors.teal,
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      // ),
      body: pages[currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updateCurrentIndex,
        currentIndex: currentSelectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Shop Icon.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Shop Icon.svg",
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Heart Icon.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Heart Icon.svg",
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Fav",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Bell.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Bell.svg",
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Notification",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/User Icon.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/User Icon.svg",
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Fav",
          ),
        ],
      ),
    );
  }
}
//////////////////////////////////////////////////////////////
