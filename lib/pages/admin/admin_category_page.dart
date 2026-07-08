import 'package:flutter/material.dart';

class AdminCategoryPage extends StatelessWidget {
  const AdminCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Kelola Kategori"),
      ),

      body: const Center(

        child: Text(
          "Halaman Category\n(Modul berikutnya)",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),

      ),

      floatingActionButton:
      FloatingActionButton(

        child: const Icon(Icons.add),

        onPressed: () {},

      ),

    );

  }

}