import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/category_provider.dart';

class AdminCategoryPage extends StatefulWidget {
  const AdminCategoryPage({super.key});

  @override
  State<AdminCategoryPage> createState() =>
      _AdminCategoryPageState();
}

class _AdminCategoryPageState
    extends State<AdminCategoryPage> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CategoryProvider>().getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider =
        context.watch<CategoryProvider>();

    return Scaffold(

      appBar: AppBar(
        title: const Text("Kategori Produk"),
      ),

      body: provider.loading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : provider.categories.isEmpty

              ? const Center(
                  child: Text(
                    "Belum ada kategori",
                  ),
                )

              : RefreshIndicator(

                  onRefresh:
                      provider.getCategories,

                  child: ListView.builder(

                    itemCount:
                        provider.categories.length,

                    itemBuilder:
                        (context, index) {

                      final category =
                          provider.categories[index];

                      return Card(

                        margin:
                            const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),

                        child: ListTile(

                          leading: CircleAvatar(

                            child: Text(
                              category.name[0]
                                  .toUpperCase(),
                            ),

                          ),

                          title:
                              Text(category.name),

                          subtitle:
                              Text(category.slug),

                        ),

                      );

                    },

                  ),

                ),

    );

  }

}