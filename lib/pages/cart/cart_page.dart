import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../widgets/cart_item_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final rupiah = NumberFormat.currency(
    locale: "id_ID",
    symbol: "Rp ",
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CartProvider>().getCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang"),
        centerTitle: true,

        actions: [
          if (provider.items.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: () async {
                await provider.clearCart();

                if (!mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Keranjang dikosongkan"),
                  ),
                );
              },
            )
        ],
      ),

      body: Builder(
        builder: (_) {
          if (provider.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.error != null) {
            return Center(
              child: Text(provider.error!),
            );
          }

          if (provider.items.isEmpty) {
            return const Center(
              child: Text(
                "Keranjang masih kosong",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: provider.getCart,
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 120),
              itemCount: provider.items.length,
              itemBuilder: (_, index) {
                final cart = provider.items[index];

                return CartItemCard(
                  cart: cart,

                  onPlus: () {
                    provider.updateQuantity(
                      cartId: cart.id,
                      quantity: cart.quantity + 1,
                    );
                  },

                  onMinus: () {
                    if (cart.quantity > 1) {
                      provider.updateQuantity(
                        cartId: cart.id,
                        quantity: cart.quantity - 1,
                      );
                    }
                  },

                  onDelete: () {
                    provider.removeItem(cart.id);
                  },
                );
              },
            ),
          );
        },
      ),

      bottomNavigationBar: provider.items.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black12,
                  )
                ],
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Item",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${provider.totalQuantity}",
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Grand Total",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          rupiah.format(provider.grandTotal),
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Halaman Checkout akan dibuat pada modul berikutnya",
                              ),
                            ),
                          );
                        },
                        child: const Text("Checkout"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}