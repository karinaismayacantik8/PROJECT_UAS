import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product_model.dart';
import '../../providers/product_provider.dart';
import '../../widgets/admin_product_card.dart';
import 'product_form_page.dart';

class AdminProductPage extends StatefulWidget {
  const AdminProductPage({super.key});

  @override
  State<AdminProductPage> createState() =>
      _AdminProductPageState();
}

class _AdminProductPageState
    extends State<AdminProductPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ProductProvider>().getProducts(
            refresh: true,
          );
    });
  }

  Future<void> _refresh() async {
    await context.read<ProductProvider>().refreshProducts();
  }

  Future<void> _delete(ProductModel product) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Hapus Produk"),
          content: Text(
            "Yakin ingin menghapus ${product.name} ?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );

    if (result != true) return;

    await context
        .read<ProductProvider>()
        .deleteProduct(product.id);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Produk berhasil dihapus"),
      ),
    );
  }

  Future<void> _openForm({
    ProductModel? product,
  }) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductFormPage(
          product: product,
        ),
      ),
    );

    if (!mounted) return;

    await _refresh();
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<ProductProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kelola Produk",
        ),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _openForm();
        },
        icon: const Icon(Icons.add),
        label: const Text("Tambah"),
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

          if (provider.products.isEmpty) {
            return const Center(
              child: Text(
                "Belum ada produk",
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              padding:
                  const EdgeInsets.all(12),
              itemCount:
                  provider.products.length,
              itemBuilder: (_, index) {
                final product =
                    provider.products[index];

                return AdminProductCard(
                  product: product,

                  onEdit: () {
                    _openForm(
                      product: product,
                    );
                  },

                  onDelete: () {
                    _delete(product);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}