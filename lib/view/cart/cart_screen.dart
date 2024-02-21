import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/model/Cart.dart';
import 'package:flutter_application_1/model/model_class.dart';
import 'package:flutter_application_1/view/cart/components/cart_card.dart';
import 'package:flutter_application_1/viewmodel/apicallprovider.dart';
import 'package:flutter_application_1/viewmodel/cartprovider.dart';
import 'package:flutter_application_1/viewmodel/razorpay.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'components/check_out_card.dart';

// Other imports...

class CartScreen extends StatefulWidget {
  //static String routeName = "/cart";
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cart = FirebaseFirestore.instance
      .collection('cart')
      .doc(FirebaseAuth.instance.currentUser?.uid);
  int totalPrize = 0;
  RazorPayIntegration razorPayIntegration = RazorPayIntegration();
  final _razorpay = Razorpay();
  final razorPayIntegrationobj = RazorPayIntegration();

  @override
  void initState() {
    //razorPayIntegration.paymentHandling(context);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    totalPrize = Provider.of<CartProvider>(context).totalPrice;
    final providerOb = Provider.of<ApiCallProvider>(context);
    final providerObj = Provider.of<CartProvider>(context);
    if (providerObj.isAlreadyCalculated == false) {
      Provider.of<CartProvider>(context).getTotalPrice();
      providerObj.isAlreadyCalculated = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: StreamBuilder(
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
            List<dynamic> document = cartData['cartList'];

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
                          providerObj.deleteFieldFromDocument(index);
                        });
                      },
                      background: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 20,
              color: const Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset("assets/icons/receipt.svg"),
                  ),
                  const Spacer(),
                  const Text("Add voucher code"),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: kTextColor,
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: "Total:\n",
                        children: [
                          TextSpan(
                            text: "\$${providerObj.totalPrice}",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        razorPayIntegration.paymentResponse(context);
                        razorPayIntegration
                            .razorPayFunction(providerObj.totalPrice);
                      },
                      child: const Text("Check Out"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
