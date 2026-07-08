import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/admin_provider.dart';
import 'category/admin_category_page.dart';
import 'product/admin_product_page.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() =>
      _AdminDashboardState();
}

class _AdminDashboardState
    extends State<AdminDashboard> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<AdminProvider>().loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider =
        context.watch<AdminProvider>();

    return Scaffold(

      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        centerTitle: true,
      ),

      body: RefreshIndicator(

        onRefresh: () =>
            provider.loadDashboard(),

        child: provider.loading

            ? const Center(
                child:
                    CircularProgressIndicator(),
              )

            : ListView(

                padding:
                    const EdgeInsets.all(16),

                children: [

                  const Text(

                    "Selamat Datang Admin",

                    style: TextStyle(

                      fontSize: 24,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                  const SizedBox(height: 20),

                  GridView.count(

                    shrinkWrap: true,

                    physics:
                        const NeverScrollableScrollPhysics(),

                    crossAxisCount: 2,

                    crossAxisSpacing: 12,

                    mainAxisSpacing: 12,

                    childAspectRatio: 1.3,

                    children: [

                      _buildCard(

                        title: "Produk",

                        value: provider.totalProduct
                            .toString(),

                        color: Colors.blue,

                        icon:
                            Icons.shopping_bag,

                      ),

                      _buildCard(

                        title: "Kategori",

                        value: provider
                            .totalCategory
                            .toString(),

                        color: Colors.orange,

                        icon: Icons.category,

                      ),

                      _buildCard(

                        title: "User",

                        value: provider.totalUser
                            .toString(),

                        color: Colors.green,

                        icon: Icons.people,

                      ),

                      _buildCard(

                        title: "Order",

                        value:
                            provider.totalOrder
                                .toString(),

                        color: Colors.red,

                        icon:
                            Icons.receipt_long,

                      ),

                    ],

                  ),

                  const SizedBox(height: 30),

                  const Text(

                    "Menu Admin",

                    style: TextStyle(

                      fontSize: 20,

                      fontWeight:
                          FontWeight.bold,

                    ),

                  ),

                  const SizedBox(height: 15),

                  ListTile(

                    leading: const Icon(
                      Icons.shopping_bag,
                    ),

                    title: const Text(
                      "Kelola Produk",
                    ),

                    trailing:
                        const Icon(Icons.chevron_right),

                    onTap: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                              const AdminProductPage(),

                        ),

                      );

                    },

                  ),

                  ListTile(

                    leading: const Icon(
                      Icons.category,
                    ),

                    title: const Text(
                      "Kelola Kategori",
                    ),

                    trailing:
                        const Icon(Icons.chevron_right),

                    onTap: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                              const AdminCategoryPage(),

                        ),

                      );

                    },

                  ),

                ],

              ),

      ),

    );

  }

  Widget _buildCard({

    required String title,

    required String value,

    required IconData icon,

    required Color color,

  }) {

    return Card(

      elevation: 3,

      shape: RoundedRectangleBorder(

        borderRadius:
            BorderRadius.circular(16),

      ),

      child: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            CircleAvatar(

              backgroundColor:
                  color.withOpacity(.15),

              child: Icon(

                icon,

                color: color,

              ),

            ),

            const SizedBox(height: 10),

            Text(

              value,

              style: const TextStyle(

                fontSize: 24,

                fontWeight:
                    FontWeight.bold,

              ),

            ),

            const SizedBox(height: 5),

            Text(title),

          ],

        ),

      ),

    );

  }

}