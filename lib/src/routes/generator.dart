import 'package:flutter/material.dart';
import 'package:pavlok_challenge/src/pages/home/home_page.dart';
import 'package:pavlok_challenge/src/pages/setTime/set_time_page.dart';
import 'package:pavlok_challenge/src/routes/routes.dart';

class RouteGenerator {
  static Route<dynamic> onGenerate(RouteSettings settings) {
    // final params = settings.arguments;
    switch (settings.name) {
      case Routes.setTime:
        return MaterialPageRoute(
          builder: (_) => const SetTimePage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
    }
  }
}
