import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/product_card.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/model/model_class.dart';
import 'package:flutter_application_1/view/details/details_screen.dart';
import 'package:flutter_application_1/viewmodel/apicallprovider.dart';
import 'package:flutter_application_1/viewmodel/cartprovider.dart';
import 'package:flutter_svg/svg.dart';
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
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                // Check if the "items" field exists in the document
                if (snapshot.hasData && snapshot.data!.exists) {
                  // Access the "items" field and display the list
                  Map<String, dynamic> cartData = snapshot.data!.data()!;
                  List<dynamic> document = cartData['wishList'];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      itemCount: document.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Dismissible(
                            key: Key(document[index]['id'].toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              setState(() {
                                providerObj.deleteFieldFromWishlist(index);
                              });
                            },
                            background: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFE6E6),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  const Spacer(),
                                  SvgPicture.asset("assets/icons/Trash.svg"),
                                ],
                              ),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 88,
                                  child: AspectRatio(
                                    aspectRatio: 0.88,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF5F6F9),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Image.network(
                                          '${document[index]['thumbnail']}'),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      document[index]['title'],
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      maxLines: 2,
                                    ),
                                    const SizedBox(height: 8),
                                    Text.rich(
                                      TextSpan(
                                        text:
                                            '\$${document[index]['price'].toString()}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: kPrimaryColor),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(child: Text("no data"));
                }
              },
            ),
            //  StreamBuilder(
            //   stream: cart.snapshots(),
            //   builder: (context, AsyncSnapshot snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Center(child: CircularProgressIndicator());
            //     }
            //     if (!snapshot.hasData ||
            //         snapshot.data == null ||
            //         snapshot.data!.data() == null) {
            //       return Center(child: Text('No data'));
            //     }
            //     Map<String, dynamic> cartData = snapshot.data!.data()!;
            //     List<dynamic> document = cartData['wishList'];

            //     // if (snapshot.hasData) {
            //     //   Map<String, dynamic> cartData = snapshot.data!.data();
            //     //   List<dynamic> document = cartData['wishList'];

            //     return Padding(
            //       padding: const EdgeInsets.all(16),
            //       child: GridView.builder(
            //           // scrollDirection: Axis.vertical,
            //           // physics: BouncingScrollPhysics(),
            //           // shrinkWrap: true,
            //           padding: EdgeInsets.zero,
            //           gridDelegate:
            //               const SliverGridDelegateWithMaxCrossAxisExtent(
            //             maxCrossAxisExtent: 200,
            //             childAspectRatio: 0.7,
            //             mainAxisSpacing: 20,
            //             crossAxisSpacing: 16,
            //           ),
            //           itemCount: document.length,
            //           itemBuilder: (context, index) => ProductCard(
            //               product: proProvider.fetchData. products[index],
            //               onPress: () {
            //                 Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                     builder: (context) => DetailsScreen(
            //                         product: proProvider.fetchData. products[index]
            //                         // ,proooducts:demoProducts
            //                         //[index],
            //                         ),
            //                   ),
            //                 );
            //               })),
            //     );
            //     // }

            //     // return Container();
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}
