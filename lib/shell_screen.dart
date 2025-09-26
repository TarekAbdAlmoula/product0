import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:product0/app_route_constants.dart';

class ShellScreen extends StatefulWidget {
  final Widget child;
  const ShellScreen({super.key, required this.child});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int selectedItem = 4;
  void onTap(int index) {
    switch (index) {
      case 0:
        context.goNamed(AppRouteConstants.about);
      case 1:
        context.goNamed(AppRouteConstants.profile);
      case 2:
        context.goNamed(AppRouteConstants.premieum);
      case 3:
        context.goNamed(AppRouteConstants.notification);
      case 4:
        return context.goNamed(AppRouteConstants.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: ConvexAppBar(
        // backgroundColor: Colors.white,
        items: [
          TabItem(icon: Icons.info, title: 'عن التطبيق'),

          TabItem(icon: Icons.people, title: 'ملفي'),
          TabItem(
            icon: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                // borderRadius: BorderRadius.circular(40),
              ),
              child: SvgPicture.asset(
                'assets/images/crown.svg',
                color: Colors.amber.shade300,
              ),
            ),
            isIconBlend: false,
          ),

          TabItem(icon: Icons.notifications_active, title: 'الاشعارات'),

          TabItem(icon: Icons.home, title: 'الرئيسية'),
        ],
        style: TabStyle.fixedCircle,
        initialActiveIndex: selectedItem,
        onTap: onTap,
      ),
    );
  }
}
