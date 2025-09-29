import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product0/core/api/dio_consumer.dart';
import 'package:product0/core/utils/app_images.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/about/data/datasource/remote/about_remote_source_impl.dart';
import 'package:product0/screens/about/data/repository/about_repository_impl.dart';
import 'package:product0/screens/about/ui/viewmodel/about_state.dart';
import 'package:product0/screens/about/ui/viewmodel/about_viewmodel.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AboutViewmodel(
        aboutRepositoryImpl: AboutRepositoryImpl(
          aboutRemoteSource: AboutRemoteSourceImpl(
            api: DioConsumer(dio: Dio()),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kMainColor,
          title: const Text('عن التطبيق'),
          centerTitle: true,
        ),
        body: const AboutScreenBody(),
      ),
    );
  }
}

class AboutScreenBody extends StatelessWidget {
  const AboutScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutScreenLogo();
  }
}

class AboutScreenLogo extends StatelessWidget {
  const AboutScreenLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutViewmodel, AboutState>(
      builder: (context, state) {
        if (state.uiState == UiState.loading) {
          return const Center(
            child: CircularProgressIndicator(color: kMainColor),
          );
        } else if (state.uiState == UiState.data) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.01,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      color: Color(0xffEEEEEE),
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'من نحن؟',
                        style: TextStyle(
                          fontSize: 25,

                          fontWeight: FontWeight.bold,
                          color: Color(0xff094067),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      state.about[0].aboutUs,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'مايميزنا؟',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 25,

                          fontWeight: FontWeight.bold,
                          color: Color(0xff094067),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.about[0].features.length,
                      itemBuilder: (context, index) {
                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            '-${state.about[0].features[index]}',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'تواصل معنا',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 25,

                          fontWeight: FontWeight.bold,
                          color: Color(0xff094067),
                        ),
                      ),
                    ],
                  ),
                  ContuctUs(
                    email: state.about[0].contactInfo.email,
                    phone: state.about[0].contactInfo.phone,
                    website: state.about[0].contactInfo.website,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  // AnimatedBorderCircle(),
                ],
              ),
            ),
          );
        } else {
          return Text('data');
        }
      },
    );
  }
}

class AnimatedBorderCircle extends StatefulWidget {
  const AnimatedBorderCircle({super.key});

  @override
  State<AnimatedBorderCircle> createState() => _AnimatedBorderCircleState();
}

class _AnimatedBorderCircleState extends State<AnimatedBorderCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(); // يجعل الحركة مستمرة
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BorderPainter(animation: _controller),
      child: SizedBox(width: 200, height: 200),
    );
  }
}

class BorderPainter extends CustomPainter {
  final Animation<double> animation;

  BorderPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 6;
    double radius = (size.width / 2) - strokeWidth;

    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // زاوية البداية للحركة
    double startAngle = animation.value * 2 * pi;

    // رسم قوس (جزء من الدائرة) يمثل الخط المتحرك
    canvas.drawArc(
      Rect.fromCircle(center: size.center(Offset.zero), radius: radius),
      startAngle,
      pi / 3, // طول القوس (يمكن تغييره ليطول أو يقصر الخط)
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) => true;
}

class ContuctUs extends StatelessWidget {
  const ContuctUs({
    super.key,
    required this.phone,
    required this.email,
    required this.website,
  });
  final String phone;
  final String email;
  final String website;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('لأي استفسار أو ملاحظات يمكنك التواصل معنا عير'),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: email,
                    style: TextStyle(color: kMainColor),
                  ),
                  TextSpan(
                    text: ' : البريد الألكتروني',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            Icon(Icons.email, color: kMainColor),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: phone,
                    style: TextStyle(color: kMainColor),
                  ),
                  TextSpan(
                    text: ' : واتساب',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/whatsapp.png',
              height: MediaQuery.of(context).size.height * 0.04,
              width: MediaQuery.of(context).size.width * 0.06,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: website,
                    style: TextStyle(color: kMainColor),
                  ),
                  TextSpan(
                    text: ' : الموقع الألكتروني',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            Icon(Icons.web, color: kMainColor),
          ],
        ),
      ],
    );
  }
}
