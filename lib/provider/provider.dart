import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model_class/model_Class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class provider extends ChangeNotifier {
  List<Product> products = [];

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('https://dummyjson.com/products'));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        // Assuming that the actual products are stored under a key like 'products'
        List<dynamic> productList = responseData['products'];

        List<Product> fetchedPosts =
            productList.map((postJson) => Product.fromJson(postJson)).toList();

        products = fetchedPosts;
        notifyListeners();
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void toggleWishlist(int index) {
    products[index].inWishlist = !products[index].inWishlist;
    notifyListeners();
  }

  final CollectionReference cart =
      FirebaseFirestore.instance.collection('cart');
 
}
