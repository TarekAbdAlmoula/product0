import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product0/models/workshop.dart';

class HomeWorkshopCard extends StatelessWidget {
  final Workshop workshop;
  final GestureTapCallback? press;
  const HomeWorkshopCard({
    super.key,
    required this.press,
    required this.workshop,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            // padding: const EdgeInsets.all(3),
            height: 160,
            width: 140,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 0.6,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  height: 90,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(workshop.featuredImageUrl),
                    ),
                  ),
                  child: ClipRRect(borderRadius: BorderRadius.circular(10)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        // textAlign: TextAlign.end,
                        workshop.title,
                        maxLines: 1,
                        style: const TextStyle(color: Colors.black),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height *
                                      0.009,
                                ),
                                child: SvgPicture.asset(
                                  "assets/icons/Star.svg",
                                  color: Color(0xFFEEA939),
                                  height: 10,
                                ),
                              ),
                              Text(
                                ((workshop.rating / 5) * 100)
                                            .toString()
                                            .length >
                                        4
                                    ? '${((workshop.rating / 5) * 100).toString().substring(0, 4)}%'
                                    : '${((workshop.rating / 5) * 100).toString()}%',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'ID:${workshop.code.toString()}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
    );
  }
}
