import 'package:flutter/material.dart';

import 'config/app_routes.dart';
import 'config/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Besar Mobile',

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      initialRoute: AppRoutes.splash,

      routes: AppRoutes.routes,
    );
  }
}