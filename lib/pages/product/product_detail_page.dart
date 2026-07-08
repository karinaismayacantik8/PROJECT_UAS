import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/product_model.dart';
import '../../providers/cart_provider.dart';
import '../../services/product_service.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailPage> createState() =>
      _ProductDetailPageState();
}

class _ProductDetailPageState
    extends State<ProductDetailPage> {
  final ProductService _service = ProductService();

  ProductModel? product;

  bool loading = true;
  bool addingCart = false;

  String? error;

  final rupiah = NumberFormat.currency(
    locale: "id_ID",
    symbol: "Rp ",
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    loadProduct();
  }

  Future<void> loadProduct() async {
    try {
      product = await _service.getProductDetail(
        widget.productId,
      );
    } catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      loading = false;
    });
  }

  Future<void> addToCart() async {
    if (product == null) return;

    setState(() {
      addingCart = true;
    });

    try {
      await context.read<CartProvider>().addToCart(
            productId: product!.id,
            quantity: 1,
          );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Produk berhasil ditambahkan ke keranjang",
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }

    if (!mounted) return;

    setState(() {
      addingCart = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (error != null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(error!),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(product!.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Hero(
              tag: product!.id,
              child: Image.network(
                product!.imageUrl,
                width: double.infinity,
                height: 320,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    height: 320,
                    color: Colors.grey.shade300,
                    child: const Icon(
                      Icons.image,
                      size: 90,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    product!.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    rupiah.format(product!.price),
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      const Icon(Icons.inventory),
                      const SizedBox(width: 8),
                      Text(
                        "Stok : ${product!.stock}",
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  if (product!.category != null)
                    Row(
                      children: [
                        const Icon(Icons.category),
                        const SizedBox(width: 8),
                        Text(
                          product!.category!.name,
                        ),
                      ],
                    ),

                  const SizedBox(height: 25),

                  const Text(
                    "Deskripsi",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    product!.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              onPressed: addingCart
                  ? null
                  : addToCart,
              icon: addingCart
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child:
                          CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(
                      Icons.shopping_cart,
                    ),
              label: Text(
                addingCart
                    ? "Menambahkan..."
                    : "Tambah ke Keranjang",
              ),
            ),
          ),
        ),
      ),
    );
  }
}