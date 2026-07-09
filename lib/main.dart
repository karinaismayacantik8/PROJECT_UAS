import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';

import 'providers/admin_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/category_provider.dart';
import 'providers/order_provider.dart';
import 'providers/product_provider.dart';
import 'providers/wishlist_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        /// ==========================
        /// AUTH
        /// ==========================
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),

        /// ==========================
        /// PRODUCT
        /// ==========================
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),

        /// ==========================
        /// CATEGORY
        /// ==========================
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
        ),

        /// ==========================
        /// ORDER
        /// ==========================
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),

        /// ==========================
        /// CART
        /// ==========================
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),

        /// ==========================
        /// WISHLIST
        /// ==========================
        ChangeNotifierProvider(
          create: (_) => WishlistProvider()..loadWishlist(),
        ),

        /// ==========================
        /// ADMIN
        /// ==========================
        ChangeNotifierProvider(
          create: (_) => AdminProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}