import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

class addCart extends StatefulWidget {
  const addCart({super.key});

  @override
  State<addCart> createState() => _addCartState();
}

class _addCartState extends State<addCart> {
  final CollectionReference cart =
      FirebaseFirestore.instance.collection('cart');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Cart'),
        ),
        body: StreamBuilder(
          stream: cart.snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot cartsnap = snapshot.data.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 400,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              height: 150,
                              width: 150,
                              child: Image.network(
                                '${cartsnap['thumbnail']}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${cartsnap['brand']}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${cartsnap['title']}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                    decoration:
                                        BoxDecoration(color: Colors.green),
                                    child: Text('${cartsnap['rating']}⭐'))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              ///////////////////////////////////////////
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '\$${cartsnap['price']}',
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${cartsnap['discountPercentage']} %Off',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Only ${cartsnap['stock']} Stocks available',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                  child: TextScroll(
                                'Delivery in 3 days',
                                intervalSpaces: 10,
                                velocity:
                                    Velocity(pixelsPerSecond: Offset(50, 0)),
                              )),
                              Text(' | FREE Delivery'),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: const Color.fromARGB(255, 19, 18, 18),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  deleteProduct(cartsnap.id);
                                },
                                child: Text('Remove'),
                                style: ElevatedButton.styleFrom(
                                    maximumSize: Size(
                                        MediaQuery.of(context).size.width / 2,
                                        50),
                                    // Set a minimum size for the button
                                    primary: Colors.blueGrey),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Buy Now'),
                                style: ElevatedButton.styleFrom(
                                  maximumSize: Size(
                                      MediaQuery.of(context).size.width / 2,
                                      50),
                                  primary: Colors.orange,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Container();
            }
          },
        ));
  }

  void deleteProduct(docId) {
    cart.doc(docId).delete();
  }
}
