import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/category_model.dart';
import '../../../models/product_model.dart';
import '../../../providers/category_provider.dart';
import '../../../providers/product_provider.dart';

class EditProductPage extends StatefulWidget {
  final ProductModel product;

  const EditProductPage({
    super.key,
    required this.product,
  });

  @override
  State<EditProductPage> createState() =>
      _EditProductPageState();
}

class _EditProductPageState
    extends State<EditProductPage> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController descController;
  late TextEditingController priceController;
  late TextEditingController stockController;
  late TextEditingController imageController;

  CategoryModel? selectedCategory;

  bool isActive = true;

  @override
  void initState() {
    super.initState();

    final product = widget.product;

    nameController =
        TextEditingController(text: product.name);

    descController =
        TextEditingController(text: product.description);

    priceController =
        TextEditingController(
      text: product.price.toString(),
    );

    stockController =
        TextEditingController(
      text: product.stock.toString(),
    );

    imageController =
        TextEditingController(
      text: product.imageUrl,
    );

    isActive = product.isActive;

    Future.microtask(() async {

      final categoryProvider =
          context.read<CategoryProvider>();

      await categoryProvider.getCategories();

      if (!mounted) return;

      for (final item
          in categoryProvider.categories) {
        if (item.id == product.categoryId) {
          selectedCategory = item;
          break;
        }
      }

      setState(() {});
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

  Future<void> updateProduct() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedCategory == null) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Pilih kategori",
          ),
        ),
      );

      return;
    }

    try {

      await context
          .read<ProductProvider>()
          .updateProduct(
            id: widget.product.id,
            name: nameController.text,
            description: descController.text,
            price: int.parse(priceController.text),
            stock: int.parse(stockController.text),
            categoryId: selectedCategory!.id,
            imageUrl: imageController.text,
            isActive: isActive,
          );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Produk berhasil diupdate",
          ),
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
        title: const Text("Edit Produk"),
      ),

      body: Form(

        key: _formKey,

        child: ListView(

          padding: const EdgeInsets.all(16),

          children: [

            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Nama Produk",
              ),
              validator: (v) =>
                  v!.isEmpty
                      ? "Wajib diisi"
                      : null,
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: descController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Deskripsi",
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: priceController,
              keyboardType:
                  TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Harga",
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: stockController,
              keyboardType:
                  TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Stock",
              ),
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
              decoration: const InputDecoration(
                labelText: "Image URL",
              ),
            ),

            const SizedBox(height: 16),

            SwitchListTile(

              value: isActive,

              title: const Text(
                "Produk Aktif",
              ),

              onChanged: (value) {

                setState(() {

                  isActive = value;

                });

              },

            ),

            const SizedBox(height: 24),

            SizedBox(

              height: 50,

              child: ElevatedButton(

                onPressed: updateProduct,

                child: const Text(
                  "Update Produk",
                ),

              ),

            ),

          ],

        ),

      ),

    );

  }

}