import 'package:flutter/material.dart';
import '../../features/home/presentation/view/screen/category_product_screen.dart';
import '../../features/home/presentation/view/screen/home_screen.dart';
import '../../features/home/presentation/view/screen/popular_sells_screen.dart';
import '../../features/home/presentation/view/screen/search_screen.dart';
import '../../features/home/presentation/view/screen/see_all_screen.dart';
import '../../features/parent/view/parent_screen.dart';
import 'route_names.dart';

class AppRoutes {
  static const String initialRoute = RouteNames.parentScreen;

  static final Map<String, WidgetBuilder> routes = {
    RouteNames.home: (context) => const HomeScreen(),
    RouteNames.parentScreen: (context) => const ParentScreen(),
    RouteNames.seeAllScreen: (context) =>  SeeAllScreen(),
    RouteNames.popularSellsScreen: (context) {
      final routeArgs = ModalRoute.of(context)?.settings.arguments;
      final String slug = routeArgs is String
          ? routeArgs
          : (routeArgs is Map ? routeArgs['product'] ?? '' : '');
      return PopularSellsScreen(productSlug: slug);
    },
    RouteNames.categoryProductsScreen: (context) {
      final categoryId = ModalRoute.of(context)?.settings.arguments as int;
      return CategoryProductsScreen(categoryId: categoryId);
    },
    RouteNames.searchScreen: (context) => const SearchScreen(),
  };

}