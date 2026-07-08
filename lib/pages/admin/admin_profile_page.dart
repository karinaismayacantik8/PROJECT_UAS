import 'package:flutter/material.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Admin"),
      ),

      body: const Center(

        child: CircleAvatar(
          radius: 50,
          child: Icon(
            Icons.admin_panel_settings,
            size: 50,
          ),
        ),

      ),

    );

  }

}