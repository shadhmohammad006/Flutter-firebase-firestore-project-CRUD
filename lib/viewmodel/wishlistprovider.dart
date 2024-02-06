import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/model_class.dart';

class WishListProvider extends ChangeNotifier{
    Product? productsFromAPI;

   List<Product> products = [];

  //   void toggleWishlist(int index) {
  //   products[index].inWishlist = !products[index].inWishlist;
  //   notifyListeners();
  // }



  bool _isPressed = false;

  bool get isPressed => _isPressed;

  void setPressed(bool value) {
    _isPressed = value;
    notifyListeners();
  }


   Future<void> updateFirestore(Product? product) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      // Handle the case when the user is not signed in.
      return;
    }

    final cartRef = FirebaseFirestore.instance.collection('cart').doc(uid);
    final cartDoc = await cartRef.get();

    List<Map<String, dynamic>> favoritetList = cartDoc['favoritetList'] ?? [];

    // Check if the product is already in the cart
    bool productExists =
        favoritetList.any((item) => item['id'] == product?.id);

    if (_isPressed && !productExists) {
      // If the product is marked as favorite and not in the cart, add it
      favoritetList.add({
        'thumbnail': product?.thumbnail,
        'price': product?.price,
        'description': product?.description,
        'discountPercentage': product?.discountPercentage,
        'rating': product?.rating,
        'stock': product?.stock,
        'title': product?.title,
        'brand': product?.brand,
        'id': product?.id,
      });
    } else if (!_isPressed && productExists) {
      // If the product is not marked as favorite and is in the cart, remove it
      favoritetList.removeWhere((item) => item['id'] == product?.id);
    }

    // Update Firestore with the modified cartList
    await cartRef.set({'favoritetList': favoritetList});
  }
}