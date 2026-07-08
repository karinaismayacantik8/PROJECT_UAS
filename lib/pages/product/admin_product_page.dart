import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/product_provider.dart';
import 'add_product_page.dart';
import 'edit_product_page.dart';

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

  @override
  Widget build(BuildContext context) {

    final provider =
        context.watch<ProductProvider>();

    return Scaffold(

      appBar: AppBar(

        title: const Text("Kelola Produk"),

      ),

      floatingActionButton: FloatingActionButton(

        child: const Icon(Icons.add),

        onPressed: () async {

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AddProductPage(),
            ),
          );

          provider.refreshProducts();

        },

      ),

      body: provider.loading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : ListView.builder(

              itemCount:
                  provider.products.length,

              itemBuilder:
                  (context, index) {

                final product =
                    provider.products[index];

                return Card(

                  margin:
                      const EdgeInsets.all(10),

                  child: ListTile(

                    leading: Image.network(

                      product.imageUrl,

                      width: 60,

                      errorBuilder:
                          (_, __, ___) {

                        return const Icon(
                          Icons.image,
                        );

                      },

                    ),

                    title: Text(
                      product.name,
                    ),

                    subtitle: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                            "Rp ${product.price}"),

                        Text(
                            "Stock : ${product.stock}"),

                      ],

                    ),

                    trailing: PopupMenuButton(

                      itemBuilder: (_) => [

                        const PopupMenuItem(

                          value: "edit",

                          child: Text(
                            "Edit",
                          ),

                        ),

                        const PopupMenuItem(

                          value: "delete",

                          child: Text(
                            "Delete",
                          ),

                        ),

                      ],

                      onSelected: (value)
                          async {

                        if (value ==
                            "edit") {

                          await Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder: (_) =>
                                  EditProductPage(
                                product:
                                    product,
                              ),

                            ),

                          );

                          provider
                              .refreshProducts();

                        }

                        if (value ==
                            "delete") {

                          final confirm =
                              await showDialog(

                            context: context,

                            builder: (_) =>
                                AlertDialog(

                              title: const Text(
                                  "Hapus Produk"),

                              content: const Text(
                                  "Yakin ingin menghapus produk ini?"),

                              actions: [

                                TextButton(

                                  onPressed: () {

                                    Navigator.pop(
                                        context,
                                        false);

                                  },

                                  child: const Text(
                                      "Batal"),

                                ),

                                ElevatedButton(

                                  onPressed: () {

                                    Navigator.pop(
                                        context,
                                        true);

                                  },

                                  child: const Text(
                                      "Hapus"),

                                ),

                              ],

                            ),

                          );

                          if (confirm ==
                              true) {

                            await provider
                                .deleteProduct(
                              product.id,
                            );

                          }

                        }

                      },

                    ),

                  ),

                );

              },

            ),

    );

  }

}