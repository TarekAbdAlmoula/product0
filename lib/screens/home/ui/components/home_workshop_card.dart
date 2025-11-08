import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        children: <Widget>[
          Container(
            width: 140.w,
            margin: EdgeInsets.symmetric(horizontal: 5.w),

            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
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
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Stack(
                  textDirection: TextDirection.rtl,
                  children: [
                    Container(
                      height: 80.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(workshop.featuredImageUrl),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        height: 22.h,
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
                          workshop.servicesCategory[1],
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 5.h),
                      Text(
                        textAlign: TextAlign.center,
                        workshop.title,
                        maxLines: 1,
                        style: const TextStyle(
                          color: kMainDarkColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 5.h),
                                child: SvgPicture.asset(
                                  "assets/icons/Star.svg",
                                  color: Color(0xFFEEA939),
                                  height: 10,
                                ),
                              ),
                              Text(
                                '${(workshop.rating).toString()}%',

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
