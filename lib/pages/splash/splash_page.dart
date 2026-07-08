import 'dart:async';

import 'package:flutter/material.dart';

import '../../config/app_routes.dart';
import '../../core/storage/shared_pref_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {

    final token = await SharedPrefService.getToken();

    Timer(const Duration(seconds: 2), () {

      if (!mounted) return;

      if (token != null && token.isNotEmpty) {

        Navigator.pushReplacementNamed(
          context,
          AppRoutes.home,
        );

      } else {

        Navigator.pushReplacementNamed(
          context,
          AppRoutes.login,
        );

      }

    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(
              Icons.shopping_bag,
              size: 90,
              color: Theme.of(context).primaryColor,
            ),

            const SizedBox(height: 20),

            const Text(
              "Tugas Besar Mobile",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "E-Commerce Flutter",
            ),

            const SizedBox(height: 40),

            const CircularProgressIndicator(),

          ],

        ),

      ),

    );

  }

}