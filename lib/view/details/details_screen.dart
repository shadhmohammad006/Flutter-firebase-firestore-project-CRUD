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
    //  required this.proooducts,
    super.key,
  });
  static String routeName = "/details";
  final Product product;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  // final Proooducts proooducts;
  int _currentIndex = 0;

  final cart = FirebaseFirestore.instance
      .collection('cart')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  /////////////////////////////
 
  ////////////////////////////

  // ...

  // ... other methods ...

  // Future<void> checkIfProductInCart() async {
  //   // Check if the product is in the cart
  //   final newdata = await cart.get();
  //   final List cartList = newdata.data()?['cartList'];
  //   bool productAlreadyInCart = cartList.any(
  //     (item) => item['id'] == widget.product?.id.toString(),
  //   );

  //   if (!productAlreadyInCart) {
  //     //cart.update(data);

  //     // totalPrice = totalPrice + (product?.price ?? 0);

  //     setState(() {
  //       isChangeButton;
  //     });
  //   } else {
  //     setState(() {
  //       isChangeButton = true;
  //     });
  //   }
  // }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // addFavtoCart(/* Product? product*/) async {
  //   final total = FirebaseFirestore.instance
  //       .collection('cart')
  //       .doc(FirebaseAuth.instance.currentUser?.uid);
  //   final users = await total.get();

  //   if (!users.exists) {
  //     total.set({
  //       'FavList': [], /*'totalPrice': 0*/
  //     });
  //   }
  //   final data = {
  //     'FavList': FieldValue.arrayUnion([
  //       {
  //         'thumbnail': widget.product.thumbnail,
  //         'price': widget.product.price,
  //         'discription': widget.product.description,
  //         'discountPercentage': widget.product.discountPercentage,
  //         'rating': widget.product.rating,
  //         'stock': widget.product.stock,
  //         'title': widget.product.title,
  //         'brand': widget.product.brand,
  //         'id': widget.product.id.toString(),
  //       }
  //     ]),
  //   };
  //   cart.update(data);

  //   setState(() {
  //     widget.product.inWishlist = true;
  //   });
  //   // notifyListeners();
  // }
///////////////////////////////////////////////////////////////////////////////////
  // addtoWishList(Product? product) async {
  //   final total = FirebaseFirestore.instance
  //       .collection('cart')
  //       .doc(FirebaseAuth.instance.currentUser?.uid);
  //   final users = await total.get();

  //   if (!users.exists) {
  //     total.set({
  //       'wishList': [],
  //     });
  //   }
  //   final data = {
  //     'wishList': FieldValue.arrayUnion([
  //       {
  //         'id': product?.id,
  //         'category': product?.category,
  //         'thumbnail': product?.thumbnail,
  //         'title': product?.title,
  //         'price': product?.price,
  //         'rating': product?.rating,
  //         'discountPercentage': product?.discountPercentage,
  //       }
  //     ]),
  //   };

  //   final newdata = await cart.get();
  //   final List cartList = newdata.data()?['cartList'];
  //   bool productAlreadyInCart =
  //       cartList.any((item) => item['id'] == product?.id);

  //   if (!productAlreadyInCart) {
  //     cart.update(data);

  //     Provider.of<CartProvider>(context).showToast("Product added");
  //   } else {
  //     Provider.of<CartProvider>(context).showToast('Product already in Cart');
  //   }
  // }
  ///////////////////////////////////////////////////////////////

  // wishListColor(Product? product) async {
  //   final newdata = await cart.get();
  //   final List cartList = newdata.data()?['cartList'];
  //   bool productAlreadyInCart =
  //       cartList.any((item) => item['id'] == product?.id);

  //   if (!productAlreadyInCart) {
  //     widget.product.inWishlist = true;
  //     setState(() {
  //       showToast("Product added");
  //     });
  //   } else {
  //     widget.product.inWishlist = false;
  //     setState(() {
  //       showToast('Product already in Cart');
  //     });
  //   }
  // }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Future<void> removeFromCart() async {
  //   // Remove the product from the cart
  //   await FirebaseFirestore.instance
  //       .collection('cart')
  //       .doc(widget.post?.id.toString())
  //       .delete();

  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text('Item removed from cart!'),
  //   ));

  //   setState(() {
  //     Provider.of<CartProvider>(context).isChangeButton = false;
  //   });
  // }

  // void goToCart() {
  //   Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (context) => addCart()));
  // }

  // final CollectionReference cart =
  //     FirebaseFirestore.instance.collection('cart');
  int selectedImage = 0;
   int selectedColor = 3;

  @override
  Widget build(BuildContext context) {
   
    // totalPrize = Provider.of<CartProvider>(context).totalPrice;
     final providerObj = Provider.of<CartProvider>(context, listen: false);
    // final providerObject = Provider.of<ApiCallProvider>(context, listen: false);

    // bool isPressed = Provider.of<WishListProvider>(context).isPressed;
    //size of the window
    // size = MediaQuery.of(context).size;
    // height = size.height;
    // width = size.width;
////////////////////////////////////////////////////////////////////////////////
    //   final ProductDetailsArguments? agrs =
    //       ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments?;
    //   if (agrs == null) {
    //   // Handle the case where arguments are null.
    //   // You might want to navigate back or show an error message.
    //   return Scaffold(
    //     body: Center(
    //       child: Text("Error: Missing product details"),
    //     ),
    //   );
    // }

    // final proooducts = agrs.proooducts;
    // final product = agrs.product;
//////////////////////////////////////////////////////////////////////
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.teal,
      //   title: SizedBox(
      //     height: 45,
      //     width: MediaQuery.sizeOf(context).width,
      //   ),
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           Navigator.of(context).push(
      //               MaterialPageRoute(builder: (context) => InitScreen()));
      //         },
      //         icon: Icon(
      //           Icons.shopping_cart,
      //           color: Colors.white,
      //         )),
      //   ],
      // ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Stack(
      //           children: [
      //             CarouselSlider(
      //               options: CarouselOptions(
      //                 height: 300,
      //                 aspectRatio: 16 / 9,
      //                 viewportFraction: 1.0,
      //                 initialPage: 0,
      //                 enableInfiniteScroll: true,
      //                 reverse: false,
      //                 autoPlay: false,
      //                 autoPlayInterval: Duration(seconds: 3),
      //                 autoPlayAnimationDuration: Duration(milliseconds: 800),
      //                 autoPlayCurve: Curves.fastOutSlowIn,
      //                 enlargeCenterPage: true,
      //                 enlargeFactor: 0.3,
      //                 onPageChanged: (index, reason) {
      //                   setState(() {
      //                     _currentIndex = index;
      //                   });
      //                 },
      //                 scrollDirection: Axis.horizontal,
      //               ),
      //               items: widget.product?.images.map((Url) {
      //                 return Builder(
      //                   builder: (BuildContext context) {
      //                     return Container(
      //                       width: MediaQuery.of(context).size.width,
      //                       margin: EdgeInsets.symmetric(horizontal: 5.0),
      //                       decoration: BoxDecoration(color: Colors.white),
      //                       child: Image.network(
      //                         Url,
      //                         fit: BoxFit.cover,
      //                       ),
      //                     );
      //                   },
      //                 );
      //               }).toList(),
      //             ),
      //             Positioned(
      //               left: 330,
      //               top: 20,
      //               child: CircleAvatar(
      //                 radius: 20,
      //                 foregroundColor: Colors.teal,
            //           child: IconButton(
            //               onPressed: () {
            //                 setState(() {
            //                   providerObj.colourBlink =
            //                       !providerObj.colourBlink;
            //                   if (providerObj.colourBlink) {
            //                     providerObj.addtoWishList(widget.product);
            //                   } else {
            //                     providerObj.wishlistDelete(widget.product);
            //                   }
            //                 });
            //               },
            //               icon: Icon(
            //                 Icons.favorite,
            //                 color: widget.product.isClick
            //                     ? Colors.red
            //                     : Colors.white,
            //               )),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
      //       DotsIndicator(
      //         dotsCount: widget.product?.images.length ??
      //             0, // Set dotsCount based on the number of images
      //         position: _currentIndex,
      //         decorator: DotsDecorator(
      //             size: const Size.square(9.0),
      //             activeSize: const Size(18.0, 9.0),
      //             activeShape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(5.0))),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(15.0),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             SizedBox(
      //               height: 10,
      //             ),
      //             Text(
      //               '${widget.product?.title}',
      //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      //             ),
      //             SizedBox(
      //               height: 10,
      //             ),
      //             Row(
      //               children: [
      //                 Text(
      //                   '\$' '${widget.product?.price}',
      //                   style: TextStyle(
      //                       fontWeight: FontWeight.bold, fontSize: 30),
      //                 ),
      //                 SizedBox(
      //                   width: 10,
      //                 ),
      //                 Text(
      //                   '${widget.product?.discountPercentage}' '% off',
      //                   style: TextStyle(
      //                       fontWeight: FontWeight.bold, color: Colors.green),
      //                 ),
      //               ],
      //             ),
      //             SizedBox(
      //               height: 10,
      //             ),
      //             Container(
      //               decoration: BoxDecoration(
      //                   color: Color.fromARGB(255, 20, 126, 24),
      //                   borderRadius: BorderRadius.circular(5)),
      //               child: Text(
      //                 '${widget.product?.rating}'
      //                 '⭐',
      //                 textAlign: TextAlign.center,
      //                 style: TextStyle(
      //                     fontSize: 13,
      //                     color: Colors.white,
      //                     fontWeight: FontWeight.bold),
      //               ),
      //             ),
      //             SizedBox(
      //               height: 10,
      //             ),
      //             Text(
      //               'Only ' '${widget.product?.stock}' ' stocks available',
      //               style: TextStyle(color: Colors.red),
      //             ),
      //             SizedBox(
      //               height: 10,
      //             ),
      //             Text(
      //               '${widget.product?.description}',
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      // bottomNavigationBar: BottomAppBar(
      //   child: Row(
      //     mainAxisSize: MainAxisSize.max,
      //     children: [
      //       ElevatedButton(
      //         onPressed: () {
      //           // if (isChangeButton) {
      //           //   goToCart();
      //           // } else {
      //           User? user = FirebaseAuth.instance.currentUser;
      //           if (user != null) {
      //             providerObj.AddtoCart(widget.product);
      //           }
      //           // }
      //           //  User? user = FirebaseAuth.instance.currentUser;
      //           //   if (user != null) {
      //           //      Provider.of<CartProvider>(context).AddtoCart(widget.product);
      //           //   }
      //         },
      //         /* child: isChangeButton ? Text("Go to Cart") : Text("Add to Cart"),*/
      //         child: Text("Add to Cart"),
      //         style: ElevatedButton.styleFrom(
      //           shape: BeveledRectangleBorder(
      //               borderRadius: BorderRadius.all(Radius.zero)),
      //           minimumSize: Size(
      //             MediaQuery.of(context).size.width / 2,
      //             50,
      //           ),
      //           backgroundColor: Colors.blueGrey,
      //         ),
      //       ),
      //       ElevatedButton(
      //         onPressed: () {
      //           // Your Buy Now logic
      //           providerObj.placeOrderFromProductPage(widget.product);
      //           razorPayIntegration.paymentResponse(context);
      //           razorPayIntegration.razorPayFunction(providerObj.totalPrice);
      //         },
      //         child: Text('Buy Now'),
      //         style: ElevatedButton.styleFrom(
      //           shape: BeveledRectangleBorder(
      //               borderRadius: BorderRadius.all(Radius.zero)),
      //           minimumSize: Size(
      //             MediaQuery.of(context).size.width / 2,
      //             50,
      //           ),
      //           backgroundColor: Colors.teal,
      //         ),
      //       )
      //     ],
      //   ),
      // ),

      // extendBody: true,
      // extendBodyBehindAppBar: true,
      // backgroundColor: const Color(0xFFF5F6F9),
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: ElevatedButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       style: ElevatedButton.styleFrom(
      //         shape: const CircleBorder(),
      //         padding: EdgeInsets.zero,
      //         elevation: 0,
      //         backgroundColor: Colors.white,
      //       ),
      //       child: const Icon(
      //         Icons.arrow_back_ios_new,
      //         color: Colors.black,
      //         size: 20,
      //       ),
      //     ),
      //   ),
      //   actions: [
      //     Row(
      //       children: [
      //         Container(
      //           margin: const EdgeInsets.only(right: 20),
      //           padding:
      //               const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(14),
      //           ),
      //           child: Row(
      //             children: [
      //               const Text(
      //                 "4.7",
      //                 style: TextStyle(
      //                   fontSize: 14,
      //                   color: Colors.black,
      //                   fontWeight: FontWeight.w600,
      //                 ),
      //               ),
      //               const SizedBox(width: 4),
      //               SvgPicture.asset("assets/icons/Star Icon.svg"),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
      // body: ListView(
      //   children: [
      //    // ProductImages(product: product),
      //     TopRoundedContainer(
      //       color: Colors.white,
      //       child: Column(
      //         children: [
      //         ///  ProductDescription(
      //           //  product: '${widget.product?.description}',
      //            // pressOnSeeMore: () {},
      //        //   ),
      //           TopRoundedContainer(
      //             color: const Color(0xFFF6F7F9),
      //             child: Column(
      //               children: [
      //                 ColorDots(product: product),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      // bottomNavigationBar: TopRoundedContainer(
      //   color: Colors.white,
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      //       child: ElevatedButton(
      //         onPressed: () {
      //           Navigator.pushNamed(context, CartScreen.routeName);
      //         },
      //         child: const Text("Add To Cart"),
      //       ),
      //     ),
      //   ),
      // ),

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
                              onPressed: () {
                                 setState(() {
                              providerObj.colourBlink =
                                  !providerObj.colourBlink;
                              if (providerObj.colourBlink) {
                                providerObj.addtoWishList(widget.product);
                              } else {
                                providerObj.wishlistDelete(widget.product);
                              }
                            });
                              },
                              icon: Icon(
                                Icons.favorite,
                                color:  widget.product.isClick
                                ? Colors.red
                                : Colors.white,
                              ))
                          // SvgPicture.asset(
                          //   "assets/icons/Heart Icon_2.svg",
                          //   // colorFilter: ColorFilter.mode(
                          //   //     product.isFavourite
                          //   //        ?
                          //   //     const Color(0xFFFF4848)
                          //   //         : const Color(0xFFDBDEE4),
                          //   //     BlendMode.srcIn
                          //   //    ),
                          //   height: 16,
                          // ),
                          ),
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


