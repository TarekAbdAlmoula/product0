import 'package:go_router/go_router.dart';
import 'package:product0/app_route_constants.dart';
import 'package:product0/models/workshop.dart';
import 'package:product0/screens/about/ui/about_screen.dart';
import 'package:product0/screens/auth/login/ui/login_screen.dart';
import 'package:product0/screens/auth/register/ui/otp_screen.dart';
import 'package:product0/screens/auth/register/ui/register_screen.dart';
import 'package:product0/screens/categories/ui/categories_screen.dart';
import 'package:product0/screens/details/ui/details_screen.dart';
import 'package:product0/screens/home/home_screen.dart';
import 'package:product0/screens/home/ui/components/search.dart';
import 'package:product0/screens/home/ui/components/showMore_screen.dart';
import 'package:product0/screens/notification/ui/notification_screen.dart';
import 'package:product0/screens/premieum/ui/form_screen.dart';
import 'package:product0/screens/premieum/ui/premieum_screen.dart';
import 'package:product0/screens/profile/ui/profile_screen.dart';
import 'package:product0/screens/splash/splash_screen.dart';
import 'package:product0/shell_screen.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: '/splash',
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
      GoRoute(
        name: AppRouteConstants.otp,
        path: '/otp/:userId',
        builder: (context, state) {
          final userId = state.pathParameters['userId'];

          return OtpScreen(userId: userId ?? '');
        },
      ),
      GoRoute(
        name: AppRouteConstants.splash,
        path: '/splash',
        builder: (context, state) {
          return SplashScreen();
        },
      ),
      GoRoute(
        name: AppRouteConstants.login,
        path: '/login',
        builder: (context, state) {
          return LoginScreen();
        },
      ),
      GoRoute(
        name: AppRouteConstants.categories,
        path: '/categories/:id/:name',
        builder: (context, state) {
          final id = state.pathParameters['id'];
          final name = state.pathParameters['name'];
          return CategoriesScreen(id: int.parse(id ?? ''), name: name ?? '');
        },
      ),
      GoRoute(
        name: AppRouteConstants.showMore,
        path: '/showMore',
        builder: (context, state) {
          final workshop = state.extra as List<Workshop>;
          return ShowmoreScreen(workshop: workshop);
        },
      ),
      GoRoute(
        name: AppRouteConstants.details,
        path: '/details',
        builder: (context, state) {
          final workshop = state.extra as Workshop;
          return DetailsScreen(workshop: workshop);
        },
      ),
      GoRoute(
        name: AppRouteConstants.search,
        path: '/search/:query',
        builder: (context, state) {
          final query = state.pathParameters['query'];

          return SearchScreen(query: query ?? '');
        },
      ),
      GoRoute(
        name: AppRouteConstants.form,
        path: '/form',
        builder: (context, state) {
          return FormScreen();
        },
      ),
    ],
  );
}
