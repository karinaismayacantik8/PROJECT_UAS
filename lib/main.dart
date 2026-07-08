import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/admin_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/category_provider.dart';
import 'providers/product_provider.dart';
import 'providers/wishlist_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => WishlistProvider()..loadWishlist(),
        ),

        // ==========================
        // Admin Provider
        // ==========================
        ChangeNotifierProvider(
          create: (_) => AdminProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}