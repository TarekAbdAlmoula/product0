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
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
                      SvgPicture.asset(
                        'assets/images/crown.svg',
                        height: 20,
                        color: Colors.amber,
                      ),
                      SizedBox(width: 57),

                      Text(
                        workshop.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff094067),
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
                      child: SvgPicture.asset('assets/icons/Star.svg'),
                    ),
                    Text(
                      '75%',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Spacer(),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                    Text(
                      'id:${workshop.code}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: SizedBox(
                height: 100,
                child: Hero(
                  tag: "hero_${workshop.code}",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(workshop.featuredImageUrl),
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
