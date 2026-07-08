import 'package:flutter/material.dart';

import '../pages/admin/admin_dashboard.dart';
import '../pages/auth/login_page.dart';
import '../pages/auth/register_page.dart';
import '../pages/cart/cart_page.dart';
import '../pages/checkout/checkout_page.dart';
import '../pages/dashboard/customer_dashboard.dart';
import '../pages/home/home_page.dart';
import '../pages/profile/profile_page.dart';
import '../pages/splash/splash_page.dart';
import '../pages/wishlist/wishlist_page.dart';

class AppRoutes {
  AppRoutes._();

  // Splash
  static const splash = "/";

  // Auth
  static const login = "/login";
  static const register = "/register";

  // Customer
  static const customerDashboard = "/customer-dashboard";
  static const home = "/home";
  static const profile = "/profile";
  static const cart = "/cart";
  static const checkout = "/checkout";
  static const wishlist = "/wishlist";
  static const orderHistory = "/order-history";

  // Admin
  static const adminDashboard = "/admin-dashboard";

  static Map<String, WidgetBuilder> routes = {
    // Splash
    splash: (_) => const SplashPage(),

    // Auth
    login: (_) => const LoginPage(),
    register: (_) => const RegisterPage(),

    // Customer
    customerDashboard: (_) => const CustomerDashboard(),
    home: (_) => const HomePage(),
    profile: (_) => const ProfilePage(),
    cart: (_) => const CartPage(),
    checkout: (_) => const CheckoutPage(),
    wishlist: (_) => const WishlistPage(),

    // Admin
    adminDashboard: (_) => const AdminDashboard(),
  };
}