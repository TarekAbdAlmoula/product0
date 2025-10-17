import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:product0/app_route_constants.dart';
import 'package:product0/core/utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainDarkColor,
        centerTitle: true,
        title: const Text('ملفي ', style: TextStyle(color: Colors.white)),
      ),
      body: IconButton(
        onPressed: () async {
          final storage = FlutterSecureStorage();
          await storage.delete(key: 'token');
          context.goNamed(AppRouteConstants.splash);
          readData();
        },
        icon: Icon(Icons.delete),
      ),
    );
  }
}

void readData() {
  print('Hello');
}
