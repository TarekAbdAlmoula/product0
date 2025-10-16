// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
    checkToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.1,
          horizontal: MediaQuery.of(context).size.width * 0.18,
        ),
        child: Column(
          children: [
            Spacer(flex: 1),
            Image.asset(
              'assets/images/splash_gif.gif',
              width: MediaQuery.of(context).size.width * 0.5,
            ),
            Spacer(),
            Text(
              'وصلة أقرب طريق لخدمتك',
              style: TextStyle(
                fontSize: 20,
                color: kMainDarkColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future checkToken() async {
    final FlutterSecureStorage _storage = FlutterSecureStorage();
    String? token = await _storage.read(key: 'token');
    Future.delayed(const Duration(seconds: 3), () {
      if (token != null) {
        context.goNamed(AppRouteConstants.home);
      } else {
        context.goNamed(AppRouteConstants.login);
      }
    });
  }
}
