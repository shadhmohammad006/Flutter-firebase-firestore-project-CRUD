import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model_class.dart';

class SearchProvider extends ChangeNotifier {
  late fligo fetchData = fligo(products: [], total: 0, skip: 0, limit: 0);

  List<Product> myList = [];
  searching(String keyWord) {
    myList = fetchData.products
        .where((item) => item.title.toLowerCase().startsWith(keyWord))
        .toList();
    notifyListeners();
  }
}
