import 'package:books_app/src/common/constants/routes.dart';
import 'package:books_app/src/presentation/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

class JobBoxRouter {
  static Route generateRoute(
      RouteSettings routeSettings, ScrollBehavior scrollBehavior) {
    return MaterialPageRoute<void>(
      settings: routeSettings,
      builder: (BuildContext context) {
        return ScrollConfiguration(
          behavior: scrollBehavior,
          child: _getScreen(
            settings: routeSettings,
          ),
        );
      },
    );
  }

  static Widget _getScreen({required RouteSettings settings}) {
    // final args = settings.arguments;
    switch (settings.name) {
      case Routes.homeScreen:
        return const DashboardScreen();
      default:
        return Container();
    }
  }
}
