import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/product_card.dart';
import 'package:flutter_application_1/model/model_class.dart';
import 'package:flutter_application_1/view/details/details_screen.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/apicallprovider.dart';

class ProductsScreen extends StatefulWidget {
  ProductsScreen({
    Key? key,
    this.product,
  }) : super(key: key);

  // static String routeName = "/products";
  Product? product;

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late ApiCallProvider proProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Start a timer that will set isLoading to false after 2 seconds
    Timer(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
    // Fetch data from the API
    proProvider = Provider.of<ApiCallProvider>(context, listen: false);
    proProvider.fetchDataFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Products",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 16,
                  ),
                  itemCount: proProvider.fetchData.products.length,
                  itemBuilder: (context, index) => ProductCard(
                    product: proProvider.fetchData.products[index],
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            product: proProvider.fetchData.products[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
