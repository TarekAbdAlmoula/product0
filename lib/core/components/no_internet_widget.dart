import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product0/core/components/custom_button.dart';
import 'package:product0/core/utils/app_images.dart';
import 'package:product0/core/utils/constants.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({
    super.key,
    required this.errorMessage,
    required this.onTap,
  });
  final String errorMessage;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          // margin: EdgeInsets.all(20),
          width: 320.w,
          height: 220.h,
          decoration: BoxDecoration(
            color: Color(0xffF8F8F8),
            shape: BoxShape.circle,
            border: Border.all(color: kMainColor, width: 1),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              child: Column(
                children: [
                  SizedBox(
                    height: 120.h,
                    width: 200.w,
                    child: Image.asset(AppImages.logoWB),
                  ),
                  Text(
                    'أسرع وصول للخدمة',
                    style: TextStyle(
                      color: Color(0xff094067),
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        SizedBox(height: 40.h),
        Center(
          child: Text(
            textAlign: TextAlign.center,
            errorMessage,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        CustomButton(
          onTap: onTap,
          color: kMainColor,
          btnText: 'إعادة المحاولة ',
        ),
      ],
    );
  }
}
