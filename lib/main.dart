import 'package:flutter/material.dart';

import 'app/routes/app_routes.dart';
import 'app/viewmodels/app_viewmodels.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await diConfig();

  runApp(
    MultiProvider(
      providers: AppViewModels.viewmodels,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter App',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.initialRoute,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}