import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:product0/app_route_constants.dart';
import 'package:product0/core/components/custom_button.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/screens/auth/data/model/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final User user = User();
  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainDarkColor,
        centerTitle: true,
        title: const Text('حسابي ', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1,
        ),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon(Icons.precision_manufacturing_outlined, size: 80),
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
                content: user.userType ?? '',
              ),
              CustomProfileCard(
                title: ':نوع الحساب',
                content: user.userType ?? '',
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              CustomButton(
                onTap: () async {
                  final storage = FlutterSecureStorage();
                  await storage.delete(key: 'token');
                  context.goNamed(AppRouteConstants.splash);
                },
                color: Colors.red,
                btnText: 'تسجيل الخروج',
              ),
              Text(
                user.userType ?? '',
                style: TextStyle(color: kMainDarkColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void readData() async {
    user.firstName = await _storage.read(key: 'username');
    user.userType = await _storage.read(key: 'accountType');
    user.email = await _storage.read(key: 'email');
    user.userType = await _storage.read(key: 'accountType');
    setState(() {});
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
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromARGB(255, 234, 234, 234),
              ),
              child: Row(children: [Text(content)]),
            ),
          ),
        ],
      ),
    );
  }
}
