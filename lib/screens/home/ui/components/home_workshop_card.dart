import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product0/core/utils/constants.dart';
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
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            // padding: const EdgeInsets.all(3),
            // height: MediaQuery.of(context).size.height * 0.,
            width: MediaQuery.of(context).size.width * 0.4,
            // height: 170,
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),

            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.black.withOpacity(0.15)),
              ),
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: Offset(0, 2), // ظل علوي
                ),
              ],
            ),
            child: Column(
              children: [
                Stack(
                  textDirection: TextDirection.rtl,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.125,
                      width: MediaQuery.of(context).size.width * 0.35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(workshop.featuredImageUrl),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        height: MediaQuery.of(context).size.height * 0.03,
                        decoration: BoxDecoration(
                          color: Color(0xffF75859),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: Text(
                          workshop.servicesCategory![0],
                          textAlign: TextAlign.end,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 5),
                      Text(
                        textAlign: TextAlign.center,
                        workshop.title,
                        maxLines: 1,
                        style: const TextStyle(
                          color: kMainDarkColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),

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
                                  color: kMainDarkColor,

                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'ID:${workshop.code.toString()}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: kMainDarkColor,
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
    );
  }
}
