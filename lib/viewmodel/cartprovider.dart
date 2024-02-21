import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/model_class.dart';

class CartProvider extends ChangeNotifier {
  Product? productsFromAPI;
  //////////////////////////////////////////////////////////////////
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    notifyListeners();
  }

////////////////////////////////////////////////////////////////////
  int totalPrice = 0;
  bool isAlreadyCalculated = false;
  final cart = FirebaseFirestore.instance
      .collection('cart')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  getTotalPrice() async {
    final data = await cart.get();
    for (var element in data.data()?['cartList']) {
      totalPrice = totalPrice + element['price'] as int;
    }
    notifyListeners();
  }

  AddtoCart(Product? product) async {
    final total = FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    final users = await total.get();

    if (!users.exists) {
      total.set({
        'cartList': [],
      });
    }
    final data = {
      'cartList': FieldValue.arrayUnion([
        {
          'thumbnail': product?.thumbnail,
          'price': product?.price,
          'discription': product?.description,
          'discountPercentage': product?.discountPercentage,
          'rating': product?.rating,
          'stock': product?.stock,
          'title': product?.title,
          'brand': product?.brand,
          'id': product?.id,
        }
      ]),
    };

    final newdata = await cart.get();
    final List cartList = newdata.data()?['cartList'];
    bool productAlreadyInCart =
        cartList.any((item) => item['id'] == product?.id);

    if (!productAlreadyInCart) {
      cart.update(data);
      print("item added in cart");

      totalPrice = totalPrice + (product?.price ?? 0);

      showToast("Product added");
    } else {
      showToast('Product already in Cart');
    }

    notifyListeners();
  }
  ////////////////////////////////////////////////////////////////////////

  addtoWishList(Product? product) async {
    final total = FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    final users = await total.get();

    if (!users.exists) {
      total.set({
        'wishList': [],
      });
    }
    final data = {
      'wishList': FieldValue.arrayUnion([
        {
          'thumbnail': product?.thumbnail,
          'price': product?.price,
          'title': product?.title,
          'id': product?.id,
        }
      ]),
    };

    final newdata = await cart.get();
    final List cartList = newdata.data()?['wishList'];
    bool productAlreadyInCart =
        cartList.any((item) => item['id'] == product?.id);

    if (!productAlreadyInCart) {
      cart.update(data);

      print("item added in cart");

      showToast("Product added");
    } else {
      showToast('Product already in Cart');
    }

    notifyListeners();
  }

///////////////////////////////////////////////////////////////////////////////////////
   bool? colourBlink;
  wishListColor(Product? product) async {
    final newdata = await cart.get();
    final List wishList = newdata.data()?['wishList'];
    bool productAlreadyInCart =
        wishList.any((item) => item['id'] == product?.id);

    if (!productAlreadyInCart) {
      cart.update(
        {'colorBlink': false},
      );
      colourBlink = false;
    } else {
      colourBlink = true;
      // showToast('Product already in Cart');
      print("alredy added color in wishlist");
    }
    notifyListeners();
  }

//////////////////////////////////////////////////////////////////////////////////////////

  void deleteFieldFromWishlist(index) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    final docRef =
        await FirebaseFirestore.instance.collection('cart').doc(userId).get();
    List<dynamic> deleteList = docRef.get('wishList');

    deleteList.removeAt(index);

    try {
      // Delete the 'cart' field from the document
      await FirebaseFirestore.instance.collection('cart').doc(userId).update({
        'wishList': deleteList,
        // 'totalPrice': totalPrices,
      });
      print('Field deleted successfully');
    } catch (e) {
      print('Error deleting field: $e');
    }
    notifyListeners();
  }

/////////////////////////////////////////////////////////////////
  void deleteFieldFromDocument(index) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    final docRef =
        await FirebaseFirestore.instance.collection('cart').doc(userId).get();
    List<dynamic> deleteList = docRef.get('cartList');

    int productPrice = deleteList[index]['price'];
    totalPrice = totalPrice - productPrice;

    deleteList.removeAt(index);

    try {
      // Delete the 'cart' field from the document
      await FirebaseFirestore.instance.collection('cart').doc(userId).update({
        'cartList': deleteList,
        // 'totalPrice': totalPrices,
      });
      print('Field deleted successfully');
    } catch (e) {
      print('Error deleting field: $e');
    }
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////
  void placeOrder(context) async {
    // Move items from cart to orders in Firestore
    List<Map<String, dynamic>> orderedItemsList = [];
    totalPrice = 0;
    final newdata = await cart.get();
    final List cartList = newdata.data()?['cartList'];
    for (var item in cartList) {
      orderedItemsList.add({
        'title': item['title'],
        'price': item['price'],
        'thumbnail': item['thumbnail'],
        // Add other fields as needed
      });
    }

    await cart.update({
      'orderList': FieldValue.arrayUnion(orderedItemsList),
      'cartList': [],
    });

    // Navigate to the order page
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => OrderPage(),
    //   ),
    // );
    notifyListeners();
  }

/////////////////////////////////////////////////////////////////////////////////
  placeOrderFromProductPage(Product product) async {
    List<Map<String, dynamic>> orderedItemsList = [];
    orderedItemsList.add({
      'title': product.title,
      'price': product.price,
      'thumbnail': product.thumbnail,
      // Add other fields as needed
    });
    await cart.update({
      'orderList': FieldValue.arrayUnion(orderedItemsList),
    });
  }
}

/////////////////////////////////////////////////////////////////////////
Future<void> createFieldinFirebase() async {
  FirebaseAuth auth = FirebaseAuth.instance;

  if (auth.currentUser != null) {
    String userId = auth.currentUser!.uid;
    final users = FirebaseFirestore.instance.collection('cart').doc(userId);

    final userssnap = await users.get();

    if (!userssnap.exists) {
      await users.set({
        'cartList': [],
        // 'total': 0,
        'Productid': [],
        'wishList': [],
        'orderList': [],
        'Address': []

        // Add more fields as needed
      });
    }
  }
}
