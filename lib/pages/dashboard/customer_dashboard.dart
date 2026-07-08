import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../cart/cart_page.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';
import '../wishlist/wishlist_page.dart';

class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() =>
      _CustomerDashboardState();
}

class _CustomerDashboardState
    extends State<CustomerDashboard> {

  int currentIndex = 0;

  final List<Widget> pages = const [

    HomePage(),

    WishlistPage(),

    CartPage(),

    ProfilePage(),

  ];

  @override
  Widget build(BuildContext context) {

    final cartProvider = context.watch<CartProvider>();

    return Scaffold(

      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: currentIndex,

        onTap: (index) {

          setState(() {
            currentIndex = index;
          });

        },

        type: BottomNavigationBarType.fixed,

        selectedItemColor: Theme.of(context).primaryColor,

        items: [

          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Wishlist",
          ),

          BottomNavigationBarItem(

            label: "Cart",

            icon: Badge(

              isLabelVisible: cartProvider.totalQuantity > 0,

              label: Text(
                cartProvider.totalQuantity.toString(),
              ),

              child: const Icon(
                Icons.shopping_cart,
              ),

            ),

          ),

          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),

        ],

      ),

    );

  }

}