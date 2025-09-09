import 'package:flutter/material.dart';
import 'package:product0/constants.dart';
import 'package:product0/screens/details/details_screen.dart';
import 'package:product0/screens/home/components/categorries.dart';
import 'package:product0/screens/home/components/item_card_v2.dart';
import 'package:product0/screens/home/data/model/categories.dart';
import 'package:product0/screens/home/data/model/prod.dart';

import 'item_card.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.prod, required this.categories});
  final List<Prod> prod;
  final List<Categories> categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 230.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoriesCard(categories: categories),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Featured Products",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  // Text(
                  //   "View All ",
                  //   style: TextStyle(fontSize: 14, color: kMainDarkColor),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPaddin,
                vertical: kDefaultPaddin / 2,
              ),
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: prod.length,
                  itemBuilder: (context, index) {
                    if (prod[index].featured == true) {
                      return ItemCard(
                        prod: prod[index],
                        press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsScreen(prod: prod[index]),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top-Rated Products",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  // Text(
                  //   "View All ",
                  //   style: TextStyle(fontSize: 14, color: kMainDarkColor),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPaddin,
                vertical: kDefaultPaddin / 2,
              ),
              child: SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: prod.length < 3 ? prod.length : 3,
                  itemBuilder: (context, index) => ItemCardV2(
                    prd: prod[index],

                    press: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsScreen(prod: prod[index]),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
