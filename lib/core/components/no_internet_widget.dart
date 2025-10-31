import 'package:flutter/material.dart';
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
      children: [
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.2,
            bottom: MediaQuery.of(context).size.height * 0.05,
          ),
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            color: Color(0xffF8F8F8),
            shape: BoxShape.circle,
            border: Border.all(color: kMainColor, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 35),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Image.asset(AppImages.logoWB),
                ),
                Text(
                  'أقرب طريق لخدمتك',
                  style: TextStyle(
                    color: Color(0xff094067),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
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
    ;
  }
}
