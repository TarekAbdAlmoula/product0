import 'package:flutter/material.dart';
import 'package:product0/screens/home/data/model/prod.dart';

import '../../../constants.dart';
import 'color_and_size.dart';
import 'description.dart';

class Body extends StatelessWidget {
  final Prod prod;
  const Body({super.key, required this.prod});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPaddin,
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            productInfo(title: "Brand", product: 'adidas'),
                            const SizedBox(height: kDefaultPaddin / 2),
                            productInfo(title: "Code", product: '0000'),
                            const SizedBox(height: kDefaultPaddin / 2),
                            productInfo(title: "Leather", product: '25%'),
                            const SizedBox(height: kDefaultPaddin / 2),
                            const Text(
                              "Color",
                              style: const TextStyle(color: Color(0xFF8B2833)),
                            ),
                            Row(
                              children: const <Widget>[
                                ColorDot(
                                  color: Color(0xFF356C95),
                                  isSelected: false,
                                ),
                                ColorDot(
                                  color: Color(0xFFF88000),
                                  isSelected: false,
                                ),
                                ColorDot(
                                  color: Color(0xFFA29B9B),
                                  isSelected: false,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: Hero(
                            tag: "hero_${prod.id}",
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(20),
                              child: Image.network(prod.images[0].src),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPaddin,
              right: kDefaultPaddin,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(height: kDefaultPaddin / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      prod.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "  \$${prod.price}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Sizes(),
                const SizedBox(height: 20),
                Description(prod: prod),
                const SizedBox(height: kDefaultPaddin / 3),

                const SizedBox(height: kDefaultPaddin / 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class productInfo extends StatelessWidget {
  const productInfo({super.key, required this.product, required this.title});

  final String product;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Color(0xFF8B2833))),
        Text(
          product,
          style: TextStyle(color: Color(0xFF8B2833).withOpacity(0.5)),
        ),
      ],
    );
  }
}
