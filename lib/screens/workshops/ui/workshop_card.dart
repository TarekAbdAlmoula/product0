import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product0/screens/workshops/data/model/workshop.dart';

import '../../../core/utils/constants.dart';

class ItemCard extends StatelessWidget {
  final Workshop workshop;
  final GestureTapCallback? press;
  const ItemCard({super.key, required this.press, required this.workshop});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        padding: EdgeInsets.only(right: 10),
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: kTextColor,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Visibility(
                        visible: workshop.isFeatured,
                        child: SvgPicture.asset(
                          'assets/images/crown.svg',
                          height: 20,
                          color: Colors.amber,
                        ),
                      ),
                      SizedBox(width: 25),

                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.43,
                        child: Text(
                          textAlign: TextAlign.end,
                          workshop.title,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff094067),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 160,
                  child: Text(
                    textAlign: TextAlign.end,
                    workshop.content,
                    style: TextStyle(fontSize: 12),
                    maxLines: 3,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5, right: 2),
                      child: SvgPicture.asset(
                        'assets/icons/Star.svg',
                        color: Colors.amber,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.14,
                      height: MediaQuery.of(context).size.height * 0.025,
                      child: Text(
                        '${((workshop.rating / 5) * 100).toString()}%',
                        style: TextStyle(
                          color: workshop.rating >= 2.5
                              ? Colors.green
                              : Colors.red,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Spacer(),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.21),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.156,
                      child: Text(
                        maxLines: 1,
                        textAlign: TextAlign.end,
                        'ID:${workshop.code}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Hero(
                tag: "hero_${workshop.code}",
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(workshop.featuredImageUrl),
                    ),
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
