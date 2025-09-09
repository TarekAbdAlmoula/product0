import 'package:flutter/material.dart';
import 'package:product0/screens/products/ui/products_screen.dart';

import '../../../constants.dart';
import '../data/model/categories.dart';

class CategoriesCard extends StatefulWidget {
  const CategoriesCard({super.key, required this.categories});

  final List<Categories> categories;
  @override
  _CategoriesCardState createState() => _CategoriesCardState();
}

class _CategoriesCardState extends State<CategoriesCard> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPaddin,
        vertical: kDefaultPaddin,
      ),
      child: SizedBox(
        height: 55,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsScreen(
                      categoryId: widget.categories[index].id,
                      title: widget.categories[index].name,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPaddin / 10,
                ),
                child: Container(
                  width: 90,
                  decoration: BoxDecoration(
                    color: const Color(0xffeaddcf),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          widget.categories[index].name,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: kMainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
