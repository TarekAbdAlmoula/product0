// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:product0/app_route_constants.dart';

import 'package:product0/core/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    delayBeforeHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 90.h, horizontal: 40.w),
          child: Column(
            children: [
              Spacer(flex: 1),
              Image.asset('assets/images/splash_gif.gif', width: 220.h),
              Spacer(),
              Text(
                'أسرع وصول للخدمة',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: kMainDarkColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future delayBeforeHome() async {
    Future.delayed(const Duration(seconds: 3), () {
      context.goNamed(AppRouteConstants.home);
    });
  }
}
