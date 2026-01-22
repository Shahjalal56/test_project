import 'package:flutter/material.dart';
import '../../features/home/presentation/view/screen/home_screen.dart';
import '../../features/parent/view/parent_screen.dart';
import 'route_names.dart';

class AppRoutes {
  static const String initialRoute = RouteNames.parentScreen;

  static final Map<String, WidgetBuilder> routes = {
    RouteNames.home: (context) => const HomeScreen(),
    RouteNames.parentScreen: (context) => const ParentScreen(),
  };
}