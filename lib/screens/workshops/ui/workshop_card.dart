import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        // height: 110.h,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
        margin: EdgeInsets.symmetric(vertical: 3.h, horizontal: 1.w),
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
          mainAxisAlignment: MainAxisAlignment.center,
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
                        colorFilter: ColorFilter.mode(
                          Colors.amber,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    SizedBox(width: 30.w),

                    SizedBox(
                      width: 150.w,
                      child: Text(
                        textAlign: TextAlign.end,
                        workshop.title,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff094067),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 35.h,
                  width: 160.h,
                  child: Text(
                    textAlign: TextAlign.end,
                    workshop.content,
                    style: TextStyle(fontSize: 12.sp),
                    maxLines: 2,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      workshop.location.isNotEmpty
                          ? workshop.location.split('_')[0].trim()
                          : '',
                      style: TextStyle(fontSize: 13.sp, color: kMainDarkColor),
                    ),
                    SvgPicture.asset(
                      'assets/icons/location.svg',
                      height: MediaQuery.of(context).size.height * 0.017,
                      width: 4,
                      colorFilter: ColorFilter.mode(
                        Colors.amber,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.h, right: 2.w),
                      child: SvgPicture.asset(
                        'assets/icons/Star.svg',
                        colorFilter: const ColorFilter.mode(
                          Colors.amber,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 62.w,
                      height: 18.h,
                      child: Text(
                        '${(workshop.rating).toString()}%',

                        style: TextStyle(
                          color: workshop.rating >= 2.5
                              ? Colors.green
                              : Colors.red,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 65.w),
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
              padding: EdgeInsets.only(left: 5.w),
              child: Hero(
                tag: "hero_${workshop.code}",
                child: Container(
                  width: 110.w,
                  height: 110.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffA3A3A3)),
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
