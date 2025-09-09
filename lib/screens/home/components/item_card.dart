import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product0/screens/home/data/model/prod.dart';

import '../../../constants.dart';

class ItemCard extends StatelessWidget {
  final Prod prod;
  final GestureTapCallback? press;
  const ItemCard({super.key, required this.press, required this.prod});

  @override
  /*************  ✨ Windsurf Command ⭐  *************/
  /// Returns a widget that displays a product card in the home screen.
  ///
  /// This includes the product image, name, rating, and price.
  ///
  /// The product image is displayed as a Hero widget with a tag of
  /// "hero_${prod.id}", which is used to create a shared animation
  /// transition when navigating to the product details screen.
  ///
  /// The product name is displayed with a maxLines of 1, so it will be
  /// ellipsized if it is too long.
  ///
  /// The product rating is displayed as a row of stars with the rating
  /// count displayed next to it.
  ///
  /// The product price is displayed in bold text.
  ///
  /// The entire widget is wrapped in a GestureDetector with an onTap
  /// callback that is passed in as a parameter. This is used to navigate
  /// to the product details screen when the card is tapped.
  ///
  /*******  153bd985-88c6-4e3f-8d94-79b630f481b2  *******/
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPaddin / 2,
        vertical: kDefaultPaddin / 4,
      ),
      child: GestureDetector(
        onTap: press,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(kDefaultPaddin / 3),
                  height: 190,
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: kTextColor,
                        spreadRadius: 0.1,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 125,
                        child: Hero(
                          tag: "hero_${prod.id}",
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(prod.images[0].src),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: kDefaultPaddin / 4,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              prod.name,
                              maxLines: 1,
                              style: const TextStyle(color: Colors.black),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/Star.svg",
                                      color: Color(0xFFEEA939),
                                      height: 10,
                                    ),
                                    Text(
                                      " ${prod.ratingCount}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "\$ ${prod.price}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Positioned(top: 10, right: 10, child: FavIcon(product: product)),
          ],
        ),
      ),
    );
  }
}
