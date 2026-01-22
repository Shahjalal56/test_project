import 'package:flutter/material.dart';


class AppRoutes {
  static const String home = '/';


  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    // other: (context) => const OtherScreen(),
  };
}