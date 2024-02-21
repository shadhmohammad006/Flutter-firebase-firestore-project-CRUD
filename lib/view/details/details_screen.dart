import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/rounded_icon_btn.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/model/model_class.dart';
import 'package:flutter_application_1/model/proooducts.dart';
import 'package:flutter_application_1/viewmodel/apicallprovider.dart';
import 'package:flutter_application_1/viewmodel/cartprovider.dart';
import 'package:flutter_application_1/viewmodel/razorpay.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../cart/cart_screen.dart';
import 'components/color_dots.dart';
import 'components/product_description.dart';
import 'components/product_images.dart';
import 'components/top_rounded_container.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({
    required this.product,
    super.key,
  });
  static String routeName = "/details";
  final Product product;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CartProvider>(context, listen: false)
        .wishListColor(widget.product);
  }

  int _currentIndex = 0;

  final cart = FirebaseFirestore.instance
      .collection('cart')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  int selectedImage = 0;
  int selectedColor = 3;

  @override
  Widget build(BuildContext context) {
    // totalPrize = Provider.of<CartProvider>(context).totalPrice;
    final providerObj = Provider.of<CartProvider>(context, listen: false);
    Provider.of<CartProvider >(context).colourBlink;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Text(
                      '${widget.product.rating}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset("assets/icons/Star Icon.svg"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ), //////////////////////////////////////////////////////////////////////////////////

      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                width: 238,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(widget.product.images[selectedImage]),
                ),
              ),
              // SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    widget.product.images.length,
                    (index) => SmallProductImage(
                      isSelected: index == selectedImage,
                      press: () {
                        setState(() {
                          selectedImage = index;
                        });
                      },
                      image: widget.product.images[index],
                    ),
                  ),
                ],
              )
            ],
          ),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '${widget.product.title}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          width: 48,
                          decoration: BoxDecoration(
                            color:
                                // product.isFavourite
                                // ? const Color(0xFFFFE6E6)
                                // :
                                Color(0xFFF5F6F9),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () async {
                              // Check if the product is already in the wishlist
                              final total = FirebaseFirestore.instance
                                  .collection('cart')
                                  .doc(FirebaseAuth.instance.currentUser?.uid);
                              final data = await total.get();
                              final List wishlist = data.data()?['wishList'];
                              bool productAlreadyInWishlist = wishlist.any(
                                  (item) => item['id'] == widget.product.id);

                              if (productAlreadyInWishlist) {
                                // Product is in the wishlist, so remove it
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .deleteFieldFromWishlist(
                                        wishlist.indexWhere((item) =>
                                            item['id'] == widget.product.id));
                                setState(() {
                                  providerObj.colourBlink = false;
                                });
                              } else {
                                // Product is not in the wishlist, so add it
                                await Provider.of<CartProvider>(context,
                                        listen: false)
                                    .addtoWishList(widget.product);
                                setState(() {
                                  providerObj.colourBlink = true;
                                });
                              }

                              // Call the appropriate method based on whether the product is in the wishlist or not
                            },
                            icon: Icon(
                              providerObj.colourBlink!
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 64,
                      ),
                      child: Text(
                        '${widget.product.description}',
                        // maxLines: 3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: const Row(
                          children: [
                            Text(
                              "See More Detail",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: kPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    TopRoundedContainer(
                        color: Color(0xFFF6F7F9),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  ...List.generate(
                                    widget.product.colors.length,
                                    (index) => ColorDot(
                                      color: widget.product.colors[index],
                                      isSelected: index == selectedColor,
                                    ),
                                  ),
                                  Spacer(),
                                  RoundedIconBtn(
                                    icon: Icons.remove,
                                    press: () {},
                                  ),
                                  const SizedBox(width: 20),
                                  RoundedIconBtn(
                                    icon: Icons.add,
                                    showShadow: true,
                                    press: () {},
                                  ),
                                ],
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ],
            ),
          ),
        ],
      ), /////////////////////////////////////////////////////////////////////////////////
      bottomNavigationBar: TopRoundedContainer(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, CartScreen.routeName);
                Provider.of<CartProvider>(context, listen: false)
                    .AddtoCart(widget.product);
              },
              child: const Text("Add To Cart"),
            ),
          ),
        ),
      ),
    );
  }
}

// class ProductDetailsArguments {
//   final Product product;
//   final Proooducts proooducts;

//   ProductDetailsArguments({required this.product,required this.proooducts});
// }


