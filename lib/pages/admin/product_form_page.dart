import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../providers/category_provider.dart';
import '../../providers/product_provider.dart';

class ProductFormPage extends StatefulWidget {
  final ProductModel? product;

  const ProductFormPage({
    super.key,
    this.product,
  });

  @override
  State<ProductFormPage> createState() =>
      _ProductFormPageState();
}

class _ProductFormPageState
    extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController =
      TextEditingController();
  final priceController =
      TextEditingController();
  final stockController =
      TextEditingController();
  final imageController =
      TextEditingController();

  bool loading = false;

  CategoryModel? selectedCategory;

  bool isActive = true;

  bool get isEdit =>
      widget.product != null;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<CategoryProvider>()
          .getCategories();
    });

    if (isEdit) {
      final p = widget.product!;

      nameController.text = p.name;
      descriptionController.text =
          p.description;
      priceController.text =
          p.price.toString();
      stockController.text =
          p.stock.toString();
      imageController.text =
          p.imageUrl;

      isActive = p.isActive;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    stockController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider =
        context.watch<CategoryProvider>();

    if (isEdit &&
        selectedCategory == null &&
        categoryProvider.categories.isNotEmpty) {
      try {
        selectedCategory =
            categoryProvider.categories.firstWhere(
          (e) =>
              e.id ==
              widget.product!.categoryId,
        );
      } catch (_) {}
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit
              ? "Edit Produk"
              : "Tambah Produk",
        ),
      ),

      body: categoryProvider.loading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: ListView(
                padding:
                    const EdgeInsets.all(20),
                children: [

                  TextFormField(
                    controller:
                        nameController,
                    decoration:
                        const InputDecoration(
                      labelText:
                          "Nama Produk",
                      border:
                          OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty) {
                        return "Nama wajib diisi";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller:
                        descriptionController,
                    maxLines: 4,
                    decoration:
                        const InputDecoration(
                      labelText:
                          "Deskripsi",
                      border:
                          OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty) {
                        return "Deskripsi wajib diisi";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller:
                        priceController,
                    keyboardType:
                        TextInputType.number,
                    decoration:
                        const InputDecoration(
                      labelText:
                          "Harga",
                      border:
                          OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty) {
                        return "Harga wajib diisi";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller:
                        stockController,
                    keyboardType:
                        TextInputType.number,
                    decoration:
                        const InputDecoration(
                      labelText:
                          "Stok",
                      border:
                          OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty) {
                        return "Stok wajib diisi";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller:
                        imageController,
                    decoration:
                        const InputDecoration(
                      labelText:
                          "Image URL",
                      border:
                          OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty) {
                        return "Image wajib diisi";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  DropdownButtonFormField<CategoryModel>(
                    value: selectedCategory,
                    decoration:
                        const InputDecoration(
                      labelText:
                          "Kategori",
                      border:
                          OutlineInputBorder(),
                    ),
                    items: categoryProvider
                        .categories
                        .map(
                          (e) =>
                              DropdownMenuItem(
                            value: e,
                            child:
                                Text(e.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory =
                            value;
                      });
                    },
                    validator: (_) {
                      if (selectedCategory ==
                          null) {
                        return "Kategori wajib dipilih";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  SwitchListTile(
                    title: const Text(
                      "Produk Aktif",
                    ),
                    value: isActive,
                    onChanged: (value) {
                      setState(() {
                        isActive = value;
                      });
                    },
                  ),

                  const SizedBox(height: 30),
                                    SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: loading ? null : saveProduct,
                      child: loading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              isEdit
                                  ? "Update Produk"
                                  : "Simpan Produk",
                            ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> saveProduct() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Silakan pilih kategori.",
          ),
        ),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final provider =
          context.read<ProductProvider>();

      if (isEdit) {
        await provider.updateProduct(
          id: widget.product!.id,
          name: nameController.text.trim(),
          description:
              descriptionController.text.trim(),
          price: int.parse(
            priceController.text,
          ),
          stock: int.parse(
            stockController.text,
          ),
          categoryId:
              selectedCategory!.id,
          imageUrl:
              imageController.text.trim(),
          isActive: isActive,
        );
      } else {
        await provider.createProduct(
          name: nameController.text.trim(),
          description:
              descriptionController.text.trim(),
          price: int.parse(
            priceController.text,
          ),
          stock: int.parse(
            stockController.text,
          ),
          categoryId:
              selectedCategory!.id,
          imageUrl:
              imageController.text.trim(),
        );
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            isEdit
                ? "Produk berhasil diperbarui"
                : "Produk berhasil ditambahkan",
          ),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }

    if (!mounted) return;

    setState(() {
      loading = false;
    });
  }
}