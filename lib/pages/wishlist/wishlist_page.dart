import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
import '../../providers/wishlist_provider.dart';
import '../../widgets/wishlist_card.dart';
import '../product/product_detail_page.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() =>
      _WishlistPageState();
}

class _WishlistPageState
    extends State<WishlistPage> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await context
          .read<WishlistProvider>()
          .loadWishlist();

      await context
          .read<ProductProvider>()
          .getProducts(refresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final wishlist =
        context.watch<WishlistProvider>();

    final productProvider =
        context.watch<ProductProvider>();

    final products = productProvider.products
        .where(
          (e) =>
              wishlist.ids.contains(e.id),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist"),
        centerTitle: true,
      ),

      body: productProvider.loading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : products.isEmpty

              ? const Center(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 80,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Wishlist masih kosong",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                )

              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (_, index) {
                    final product =
                        products[index];

                    return WishlistCard(
                      product: product,

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailPage(
                              productId:
                                  product.id,
                            ),
                          ),
                        );
                      },

                      onRemove: () {
                        wishlist.toggle(
                          product.id,
                        );
                      },
                    );
                  },
                ),
    );
  }
}