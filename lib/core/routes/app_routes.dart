import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba/core/routes/menu/menu_routes.dart';

enum TypeTransition { rightToLeft, leftToRight, topToBottom, bottomToTop }

class AppRoutes {
  static final GlobalKey<NavigatorState> onBoardingNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> onMenuNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> onDashboardNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> onSettingsNavigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter onConfigRouter() => GoRouter(
    initialLocation: RouteNames.apiList.path,
    navigatorKey: onBoardingNavigatorKey,
    debugLogDiagnostics: true,
    routes: [AppRoutesMenu.menuRoutes],
  );

  static CustomTransitionPage Function(LocalKey pagekey, Widget view)
  get viewMaterial => _materialRoute;

  static CustomTransitionPage _materialRoute(LocalKey pagekey, Widget view) {
    return CustomTransitionPage(
      key: pagekey,
      child: view,
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animationInit, secondaryAnimation, child) {
        final fadeAnimation = CurvedAnimation(
          parent: animationInit,
          curve: Curves.easeInOut,
        );
        return FadeTransition(opacity: fadeAnimation, child: child);
      },
    );
  }
}
