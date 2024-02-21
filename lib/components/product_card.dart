import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model_class.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../viewmodel/apicallprovider.dart';
import '../viewmodel/cartprovider.dart';

class ProductCard extends StatefulWidget {
  ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
    required this.onPress,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;
  final VoidCallback onPress;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final providerObj = Provider.of<CartProvider>(context, listen: false);
    // final proProvider = Provider.of<ApiCallProvider>(context);

    return SizedBox(
      width: widget.width,
      child: GestureDetector(
        onTap: widget.onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.02,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.network(widget.product.thumbnail),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                widget.product.title,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '\$${widget.product.price}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
                // InkWell(
                //   borderRadius: BorderRadius.circular(50),
                //   onTap: () {
                //     setState(() {
                //       providerObj.colourBlink = !providerObj.colourBlink;
                //       if (providerObj.colourBlink) {
                //         providerObj.addtoWishList(widget.product);
                //       } else {
                //         providerObj.wishlistDelete(widget.product);
                //       }
                //     });
                //   },
                //   child: Container(
                //     padding: const EdgeInsets.all(6),
                //     height: 24,
                //     width: 24,
                //     decoration: BoxDecoration(
                //       color: widget.product.isClick
                //           ? kPrimaryColor.withOpacity(0.15)
                //           : kSecondaryColor.withOpacity(0.1),
                //       shape: BoxShape.circle,
                //     ),
                //     child: SvgPicture.asset(
                //       "assets/icons/Heart Icon_2.svg",
                //       //  colorFilter: ColorFilter.mode(
                //       // proProvider.products.isFavourite
                //       //   ?
                //       //   const Color(0xFFFF4848)
                //       //  : const Color(0xFFDBDEE4),
                //       //BlendMode.srcIn
                //       //  )
                //       color: widget.product.isClick
                //           ? const Color(0xFFFF4848)
                //           : const Color(0xFFDBDEE4),
                //     ),
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
