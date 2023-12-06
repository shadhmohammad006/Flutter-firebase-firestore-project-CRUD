import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model_class/model_Class.dart';
import 'package:flutter_application_1/model_class/widgets/Add_to_cart.dart';
import 'package:flutter_application_1/model_class/widgets/wishlist.dart';
import 'package:flutter_application_1/provider/provider.dart';
import 'package:provider/provider.dart';

class WidgetPage extends StatefulWidget {
  final Product? post;
  const WidgetPage({this.post, super.key});

  @override
  State<WidgetPage> createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  final CollectionReference cart =
      FirebaseFirestore.instance.collection('cart');
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 45,
          width: MediaQuery.sizeOf(context).width,
          child: TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.white70),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WishList(),
                ));
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => addCart()));
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              )),
        ],
        // title: Text(
        //   '${widget.post?.brand}',
        //   style: TextStyle(fontWeight: FontWeight.bold),
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 300,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: false,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                ),
                items: widget.post?.images.map((Url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(color: Colors.white),
                        child: Image.network(
                          Url,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            DotsIndicator(
              dotsCount: widget.post?.images.length ??
                  0, // Set dotsCount based on the number of images
              position: _currentIndex,
              decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${widget.post?.title}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        '\$' '${widget.post?.price}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${widget.post?.discountPercentage}' '% off',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 20, 126, 24),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      '${widget.post?.rating}'
                      '⭐',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Only ' '${widget.post?.stock}' ' stocks available',
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${widget.post?.description}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Storecart();
              },
              child: Text('Add to Cart'),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    MediaQuery.of(context).size.width /
                        2, // Set width based on screen width
                    50, // Set a fixed height
                  ),

                  // Set a minimum size for the button
                  primary: Colors.blueGrey),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Buy Now'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                  MediaQuery.of(context).size.width /
                      2, // Set width based on screen width
                  50, // Set a fixed height
                ),
                primary: Colors.orange,
              ),
            )
          ],
        ),
      ),
    );
  }

  void Storecart() {
    final data = {
      'thumbnail': widget.post?.thumbnail,
      'price': widget.post?.price,
      'discription': widget.post?.description,
      'discountPercentage': widget.post?.discountPercentage,
      'rating': widget.post?.rating,
      'stock': widget.post?.stock,
      'title': widget.post?.title,
      'brand': widget.post?.brand,
      'id': widget.post?.id
    };
    cart.add(data);
  }
}
