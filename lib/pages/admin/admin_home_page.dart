import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  Widget buildCard(
      BuildContext context,
      IconData icon,
      String title,
      Color color,
      ) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor:
              color.withOpacity(.15),
              child: Icon(
                icon,
                color: color,
                size: 35,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        centerTitle: true,
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: GridView.count(

          crossAxisCount: 2,

          crossAxisSpacing: 15,

          mainAxisSpacing: 15,

          children: [

            buildCard(
              context,
              Icons.shopping_bag,
              "Kelola Produk",
              Colors.deepPurple,
            ),

            buildCard(
              context,
              Icons.category,
              "Kelola Kategori",
              Colors.orange,
            ),

            buildCard(
              context,
              Icons.receipt_long,
              "Order",
              Colors.green,
            ),

            buildCard(
              context,
              Icons.people,
              "Customer",
              Colors.blue,
            ),

          ],

        ),

      ),

    );

  }

}