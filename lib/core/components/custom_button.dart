import 'package:flutter/material.dart';
import 'package:product0/core/utils/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          color: kMainDarkColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.01,
            ),
            child: Text(
              'إرسال',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
