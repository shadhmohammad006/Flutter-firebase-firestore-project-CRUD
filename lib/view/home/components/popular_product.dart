import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/model/model_class.dart';
import 'package:flutter_application_1/view/details/details_screen.dart';
import 'package:flutter_application_1/viewmodel/apicallprovider.dart';
import 'package:provider/provider.dart';

import '../../../components/product_card.dart';
import '../../../model/proooducts.dart';
import '../../products/products_screen.dart';
import 'section_title.dart';

class PopularBrands extends StatelessWidget {
  const PopularBrands({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> popularBrands = [
      'assets/images/popular-brand/adidas.png',
      'assets/images/popular-brand/brand-hm-1.png',
      'assets/images/popular-brand/max.png',
      'assets/images/popular-brand/nike-blue.png',
      'assets/images/popular-brand/samsung-blue.png',
      'assets/images/popular-brand/apple-logo.png',
      'assets/images/popular-brand/dove-lady.png',
      'assets/images/popular-brand/garnier.png',
    ];

    final productcall = Provider.of<ApiCallProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SectionTitle(
              title: "Popular Brands",
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProductsScreen()));
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
            child: GridView.builder(
                itemCount: popularBrands.length,
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // Set the number of containers in a row
                  crossAxisSpacing: 8.0, // Adjust spacing as needed
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductsScreen()));
                      },
                      child: Container(
                        // padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          //color: kSecondaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(
                          popularBrands[index],
                        ), // Adjust margin as needed
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
