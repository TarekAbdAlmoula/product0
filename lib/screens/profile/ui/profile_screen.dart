import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:product0/app_route_constants.dart';
import 'package:product0/core/components/custom_button.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/screens/auth/data/model/user.dart';
import 'package:product0/screens/home/ui/components/register_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final User user = User();
  String token = '';
  bool isLoading = true;
  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: kMainDarkColor,
        centerTitle: true,
        title: const Text('حسابي ', style: TextStyle(color: Colors.white)),
      ),
      body: isLoading
          ? Center(child: const CircularProgressIndicator(color: kMainColor))
          : token == ''
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/userBlock.png',
                    height: 150.h,
                    width: 160.w,
                  ),
                  RegisterButton(),
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Lottie.asset(
                      fit: BoxFit.fill,
                      'assets/images/Profile user card.json',
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.height * 0.3,
                    ),
                    CustomProfileCard(
                      title: ': الاسم ',
                      content: user.firstName ?? '',
                    ),
                    CustomProfileCard(
                      title: ': البريد الالكتروني ',
                      content: user.email ?? '',
                    ),
                    CustomProfileCard(
                      title: ':رقم الهاتف',
                      content: user.phoneNumber ?? '',
                    ),
                    CustomProfileCard(
                      title: ':نوع الحساب',
                      content: user.userType ?? '',
                    ),
                    CustomProfileCard(
                      title: ': الموقع ',
                      content: user.location ?? '',
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    CustomButton(
                      onTap: () async {
                        final storage = FlutterSecureStorage();
                        await storage.delete(key: 'token');
                        await storage.delete(key: 'userId');
                        await storage.delete(key: 'username');
                        await storage.delete(key: 'email');
                        await storage.delete(key: 'accountType');
                        await storage.delete(key: 'phoneNumber');
                        await storage.delete(key: 'location');
                        if (!mounted) return;
                        context.goNamed(AppRouteConstants.splash);
                      },
                      color: Colors.red,
                      btnText: 'تسجيل الخروج',
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  ],
                ),
              ),
            ),
    );
  }

  void readData() async {
    token = await _storage.read(key: 'token') ?? '';
    if (token.isNotEmpty) {
      user.firstName = await _storage.read(key: 'username');
      user.userType = await _storage.read(key: 'accountType');
      user.email = await _storage.read(key: 'email');
      user.userType = await _storage.read(key: 'accountType');
      user.phoneNumber = await _storage.read(key: 'phoneNumber');
      user.location = await _storage.read(key: 'location');
    }
    setState(() {
      isLoading = false;
    });
  }
}

class CustomProfileCard extends StatelessWidget {
  const CustomProfileCard({
    super.key,
    required this.content,
    required this.title,
  });
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kMainDarkColor,
            ),
          ),

          Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(2),
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xff9F9F9F)),
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xffF8F8F8),
              ),
              child: Row(children: [Text(content)]),
            ),
          ),
        ],
      ),
    );
  }
}
