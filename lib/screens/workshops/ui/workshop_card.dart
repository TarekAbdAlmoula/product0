import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product0/models/workshop.dart';

import '../../../core/utils/constants.dart';

class WorkshopCard extends StatelessWidget {
  final Workshop workshop;
  final GestureTapCallback? press;
  const WorkshopCard({super.key, required this.press, required this.workshop});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02,
          vertical: MediaQuery.of(context).size.height * 0.007,
        ),
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
                Row(
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: 160,
                  child: Text(
                    textAlign: TextAlign.end,
                    workshop.content,
                    style: TextStyle(fontSize: 12),
                    maxLines: 2,
                  ),
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      workshop.location.isNotEmpty
                          ? workshop.location.split('ـ')[0].trim()
                          : '',
                      style: const TextStyle(
                        fontSize: 13,
                        color: kMainDarkColor,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icons/location.svg',
                      height: MediaQuery.of(context).size.height * 0.017,
                      width: 4,
                      color: Colors.amber,
                    ),
                    // Icon(Icons.location_on, color: Colors.amber, size: 17),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.003),
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
                        ((workshop.rating / 5) * 100).toString().length > 4
                            ? '${((workshop.rating / 5) * 100).toString().substring(0, 4)}%'
                            : '${((workshop.rating / 5) * 100).toString()}%',
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
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: kMainDarkColor,
                        ),
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
                  width: MediaQuery.of(context).size.height * 0.14,
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
