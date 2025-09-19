import 'package:flutter/material.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/models/categories.dart';
import 'package:product0/screens/categories/ui/categories_screen.dart';

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
        horizontal: 10,
        vertical: kDefaultPaddin,
      ),
      child: SizedBox(
        height: 90,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoriesScreen(
                        id: widget.categories[index].id,
                        name: widget.categories[index].name,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPaddin / 10,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 3, vertical: 0.5),
                    width: 90,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          widget.categories[index].image!.ulr,
                        ),
                      ),
                      color: const Color(0xff3da9fc),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(flex: 9),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.028,
                          padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.004,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white.withOpacity(0.7),
                          ),
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              widget.categories[index].name,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Spacer(flex: 1),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
