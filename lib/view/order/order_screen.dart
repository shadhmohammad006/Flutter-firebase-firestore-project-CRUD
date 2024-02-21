import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/viewmodel/cartprovider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final cart = FirebaseFirestore.instance
      .collection('cart')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  @override
  Widget build(BuildContext context) {
    final providerObj = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "order",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: StreamBuilder(
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
          List<dynamic> document = cartData['orderList'];

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
        },
      ),
    );
  }
}
