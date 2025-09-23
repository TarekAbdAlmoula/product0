import 'package:flutter/material.dart';
import 'package:product0/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: ThemeData(fontFamily: 'Tajawal'),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
    );
  }
}
