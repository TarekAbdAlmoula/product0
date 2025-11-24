import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:product0/app_route_constants.dart';
import 'package:product0/core/utils/constants.dart';

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
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          textTheme: TextTheme(
            bodyMedium: TextStyle(color: Colors.white, fontSize: 8.sp),
          ),
        ),
        child: ConvexAppBar(
          backgroundColor: kMainDarkColor,
          height: 50.h,
          top: -17.h,
          items: [
            TabItem(icon: Icons.info, title: 'عن وصلة'),

            TabItem(icon: Icons.people, title: 'حسابي'),
            TabItem(
              icon: Transform.translate(
                offset: Offset(0, -5.w),

                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/images/add.gif'),
                    ),
                  ),
                ),
              ),
              title: 'انشر الآن',
            ),

            TabItem(icon: Icons.notifications_active, title: 'الاشعارات'),

            TabItem(icon: Icons.home, title: 'الرئيسية'),
          ],
          style: TabStyle.fixed,
          initialActiveIndex: selectedItem,
          onTap: onTap,
        ),
      ),
    );
  }
}
