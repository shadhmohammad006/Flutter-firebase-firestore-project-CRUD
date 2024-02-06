import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/product_card.dart';
import 'package:flutter_application_1/model/model_class.dart';
import 'package:flutter_application_1/view/details/details_screen.dart';
import 'package:flutter_application_1/viewmodel/apicallprovider.dart';
import 'package:flutter_application_1/viewmodel/cartprovider.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final cart = FirebaseFirestore.instance
      .collection('cart')
      .doc(FirebaseAuth.instance.currentUser?.uid);
  Product? product;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final proProvider = Provider.of<ApiCallProvider>(context);
    final providerObj = Provider.of<CartProvider>(context, listen: false);

    return SafeArea(
      child: Column(
        children: [
          Text(
            "Favorites",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(
            child: StreamBuilder(
              stream: cart.snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData ||
                    snapshot.data == null ||
                    snapshot.data!.data() == null) {
                  return Center(child: Text('No data'));
                }
                Map<String, dynamic> cartData = snapshot.data!.data()!;
                List<dynamic> document = cartData['wishList'];

                // if (snapshot.hasData) {
                //   Map<String, dynamic> cartData = snapshot.data!.data();
                //   List<dynamic> document = cartData['wishList'];

                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                      // scrollDirection: Axis.vertical,
                      // physics: BouncingScrollPhysics(),
                      // shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 0.7,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 16,
                      ),
                      itemCount: document.length,
                      itemBuilder: (context, index) => ProductCard(
                          product: proProvider.fetchData. products[index],
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                    product: proProvider.fetchData. products[index]
                                    // ,proooducts:demoProducts
                                    //[index],
                                    ),
                              ),
                            );
                          })),
                );
                // }

                // return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
