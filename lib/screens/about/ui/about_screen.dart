import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product0/core/api/dio_consumer.dart';
import 'package:product0/core/components/no_internet_widget.dart';
import 'package:product0/core/utils/app_images.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/about/data/datasource/remote/about_remote_source_impl.dart';
import 'package:product0/screens/about/data/repository/about_repository_impl.dart';
import 'package:product0/screens/about/ui/viewmodel/about_state.dart';
import 'package:product0/screens/about/ui/viewmodel/about_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AboutViewmodel(
        aboutRepositoryImpl: AboutRepositoryImpl(
          aboutRemoteSource: AboutRemoteSourceImpl(
            api: DioConsumer(
              dio: Dio(
                BaseOptions(
                  connectTimeout: const Duration(seconds: 8),
                  sendTimeout: const Duration(seconds: 8),
                  receiveTimeout: const Duration(seconds: 8),
                ),
              ),
            ),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          shadowColor: Colors.transparent,

          backgroundColor: kMainDarkColor,
          title: const Text(
            'عن التطبيق',

            style: TextStyle(color: Colors.white),
          ),
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
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Column(
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'من نحن؟',
                        style: TextStyle(
                          fontSize: 20.sp,

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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'مايميزنا؟',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,

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
                            state.about[0].features[index],
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'تواصل معنا',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,

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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  CallButton(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                ],
              ),
            ),
          );
        } else if (state.uiState == UiState.error) {
          return NoInternetWidget(
            onTap: () async {
              BlocProvider.of<AboutViewmodel>(context).fetchAboutInfo();
            },
            errorMessage: state.erroemessage ?? '',
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
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
        Text(
          'لأي استفسار أو ملاحظات يمكنك التواصل معنا عبر',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.end,
        ),
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
                    style: TextStyle(fontSize: 16, color: Colors.black),
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
                    text: website,
                    style: TextStyle(color: kMainColor, fontSize: 16),
                  ),
                  TextSpan(
                    text: ' : الموقع الألكتروني',
                    style: TextStyle(color: Colors.black, fontSize: 16),
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

class CallButton extends StatefulWidget {
  const CallButton({super.key});

  @override
  State<CallButton> createState() => _CallButtonState();
}

class _CallButtonState extends State<CallButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: ElevatedButton.icon(
        onPressed: () async {
          final String phoneNumber = "963965325745"; // رقم الهاتف بصيغة دولية
          final String message = "مرحبًا، أودّ التواصل معكم.";
          final url = Uri.parse(
            "https://wa.me/${phoneNumber.replaceAll('+', '')}?text=${Uri.encodeComponent(message)}",
          );
          await launchUrl(url, mode: LaunchMode.externalApplication);

          // if (await canLaunchUrl(url)) {
          // } else {
          //   throw 'لا يمكن فتح واتساب على هذا الجهاز';
          // }
        },
        label: const Text(
          'تواصل معنا عبر الواتساب',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: kMainDarkColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
