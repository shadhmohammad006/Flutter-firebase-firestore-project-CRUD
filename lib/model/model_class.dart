// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);
//******************************************************************************
// import 'dart:convert';

// Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

// String welcomeToJson(Welcome data) => json.encode(data.toJson());

import 'package:flutter/material.dart';

class fligo {
  List<Product> products;
  int total;
  int skip;
  int limit;

  fligo({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory fligo.fromJson(Map<String, dynamic> json) => fligo(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  // Map<String, dynamic> toJson() => {
  //     "products": List<dynamic>.from(products.map((x) => x.toJson())),
  //     "total": total,
  //     "skip": skip,
  //     "limit": limit,
  // };
}

class Product {
  int id;
  String title;
  String description;
  int price;
  double discountPercentage;
  double rating;
  int stock;
  String brand;
  String category;
  String thumbnail;
  List<String> images;
  bool isClick;
  final bool isFavourite, isPopular;
  final List<Color> colors; // New property

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
    this.isClick = false,
    this.isFavourite = false,
    this.isPopular = false,
    required this.colors,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        discountPercentage: json["discountPercentage"]?.toDouble(),
        rating: json["rating"]?.toDouble(),
        stock: json["stock"],
        brand: json["brand"],
        category: json["category"],
        thumbnail: json["thumbnail"],
        colors: [
          const Color(0xFFF6625E),
          const Color(0xFF836DB8),
          const Color(0xFFDECB9C),
          Colors.white,
        ],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  // Map<String, dynamic> toJson() => {
  //     "id": id,
  //     "title": title,
  //     "description": description,
  //     "price": price,
  //     "discountPercentage": discountPercentage,
  //     "rating": rating,
  //     "stock": stock,
  //     "brand": brand,
  //     "category": category,
  //     "thumbnail": thumbnail,
  //     "images": List<dynamic>.from(images.map((x) => x)),
  // };
}
