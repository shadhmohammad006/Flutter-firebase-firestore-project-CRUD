import 'package:flutter/material.dart';

import '../../cart/cart_screen.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child:
            // FutureBuilder<int>(
            //   // Replace this Future with your actual logic to get the number of items in the cart
            //   future: getNumberOfItemsInCart(),
            //   builder: (context, snapshot) {
            //     int numOfItems = snapshot.data ?? 0;

            //     return
            Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(child: SearchContainer()),
            SizedBox(width: MediaQuery.of(context).size.width / 25), //16
            IconBtnWithCounter(
                svgSrc: "assets/icons/Cart Icon.svg",
                //  numOfitem: 1 //numOfItems.toString(),

                press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ),
                    )),

            /// SizedBox(width: MediaQuery.of(context).size.width / 60),
          ],
        )
        //})
        );
  }
  // Future<int> getNumberOfItemsInCart() async {
  //   // Add your logic here to fetch the number of items from Firestore
  //   // For example, you can use FirebaseFirestore.instance.collection('cart')...
  //   // This function should return the actual number of items in the cart.
  //   return 0;
  //}
}
