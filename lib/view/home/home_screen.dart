import 'package:flutter/material.dart';

import 'components/categories.dart';
import 'components/discount_banner.dart';
import 'components/home_header.dart';
import 'components/popular_product.dart';
import 'components/special_offers.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            HomeHeader(),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            BannerImages(),
            Categories(),
            SpecialOffers(),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            PopularBrands(),
            //SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
