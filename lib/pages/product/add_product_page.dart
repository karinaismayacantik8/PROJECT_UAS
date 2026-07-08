import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/category_model.dart';
import '../../../providers/category_provider.dart';
import '../../../providers/product_provider.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() =>
      _AddProductPageState();
}

class _AddProductPageState
    extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final imageController = TextEditingController();

  CategoryModel? selectedCategory;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CategoryProvider>().getCategories();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    priceController.dispose();
    stockController.dispose();
    imageController.dispose();
    super.dispose();
  }

  Future<void> saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Pilih kategori"),
        ),
      );
      return;
    }

    try {
      await context.read<ProductProvider>().createProduct(
            name: nameController.text,
            description: descController.text,
            price: int.parse(priceController.text),
            stock: int.parse(stockController.text),
            categoryId: selectedCategory!.id,
            imageUrl: imageController.text,
          );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Produk berhasil ditambahkan"),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider =
        context.watch<CategoryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Produk"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: nameController,
              decoration:
                  const InputDecoration(
                labelText: "Nama Produk",
              ),
              validator: (v) =>
                  v!.isEmpty ? "Wajib diisi" : null,
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: descController,
              maxLines: 4,
              decoration:
                  const InputDecoration(
                labelText: "Deskripsi",
              ),
              validator: (v) =>
                  v!.isEmpty ? "Wajib diisi" : null,
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: priceController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText: "Harga",
              ),
              validator: (v) =>
                  v!.isEmpty ? "Wajib diisi" : null,
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: stockController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText: "Stock",
              ),
              validator: (v) =>
                  v!.isEmpty ? "Wajib diisi" : null,
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<CategoryModel>(
              value: selectedCategory,
              decoration:
                  const InputDecoration(
                labelText: "Kategori",
              ),
              items: categoryProvider.categories
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: imageController,
              decoration:
                  const InputDecoration(
                labelText: "Image URL",
              ),
              validator: (v) =>
                  v!.isEmpty ? "Wajib diisi" : null,
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: saveProduct,
                child: const Text(
                  "Simpan Produk",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}