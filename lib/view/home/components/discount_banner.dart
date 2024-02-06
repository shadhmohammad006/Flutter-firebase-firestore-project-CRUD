import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class BannerImages extends StatefulWidget {
  const BannerImages({
    Key? key,
  }) : super(key: key);

  @override
  State<BannerImages> createState() => _BannerImagesState();
}

class _BannerImagesState extends State<BannerImages> {
  final List<String> imagebanner = [
    'assets/images/scroll1.jpg',
    'assets/images/scroll2.jpg',
    'assets/images/scroll3.jpg',
    'assets/images/scroll5.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
            itemCount: imagebanner.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(),
                child: Image.asset(
                  imagebanner[index],
                  fit: BoxFit.cover,
                ),
              );
            },
            options: CarouselOptions(
              height: 150.0,
              enlargeCenterPage: true,
              autoPlay: false,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ))
      ],
    );
    // Container(
    //   width: double.infinity,
    //   margin: const EdgeInsets.all(20),
    //   padding: const EdgeInsets.symmetric(
    //     horizontal: 20,
    //     vertical: 16,
    //   ),
    //   decoration: BoxDecoration(
    //     color: const Color(0xFF4A3298),
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    //   child: const Text.rich(
    //     TextSpan(
    //       style: TextStyle(color: Colors.white),
    //       children: [
    //         TextSpan(text: "A Summer Surpise\n"),
    //         TextSpan(
    //           text: "Cashback 20%",
    //           style: TextStyle(
    //             fontSize: 24,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
