import 'package:go_router/go_router.dart';
import 'package:product0/app_route_constants.dart';
import 'package:product0/screens/about/ui/about_screen.dart';
import 'package:product0/screens/auth/register/ui/register_screen.dart';
import 'package:product0/screens/home/home_screen.dart';
import 'package:product0/screens/notification/ui/notification_screen.dart';
import 'package:product0/screens/premieum/ui/premieum_screen.dart';
import 'package:product0/screens/profile/ui/profile_screen.dart';
import 'package:product0/shell_screen.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: '/register',
    routes: [
      ShellRoute(
        builder: (context, state, child) => ShellScreen(child: child),
        routes: [
          GoRoute(
            name: AppRouteConstants.home,
            path: '/home',
            builder: (context, state) {
              return HomeScreen();
            },
          ),
          GoRoute(
            name: AppRouteConstants.notification,
            path: '/notification',
            builder: (context, state) {
              return NotificationScreen();
            },
          ),
          GoRoute(
            name: AppRouteConstants.premieum,
            path: '/premieum',
            builder: (context, state) {
              return PremieumScreen();
            },
          ),
          GoRoute(
            name: AppRouteConstants.about,
            path: '/about',
            builder: (context, state) {
              return AboutScreen();
            },
          ),
          GoRoute(
            name: AppRouteConstants.profile,
            path: '/profile',
            builder: (context, state) {
              return ProfileScreen();
            },
          ),
        ],
      ),
      GoRoute(
        name: AppRouteConstants.register,
        path: '/register',
        builder: (context, state) {
          return RegisterScreen();
        },
      ),
      // GoRoute(
      //   name: AppRouteConstants.otp,
      //   path: '/otp',
      //   builder: (context, state) {
      //     return OtpScreen();
      //   },
      // ),
    ],
  );
}
