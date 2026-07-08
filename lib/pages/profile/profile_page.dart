import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/app_routes.dart';
import '../../providers/auth_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<AuthProvider>().getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {

    final auth = context.watch<AuthProvider>();
    final user = auth.user;

    return Scaffold(

      appBar: AppBar(
        title: const Text("Profil"),
        centerTitle: true,
      ),

      body: auth.isLoading

          ? const Center(
              child: CircularProgressIndicator(),
            )

          : user == null

              ? const Center(
                  child: Text("Data pengguna tidak ditemukan"),
                )

              : SingleChildScrollView(

                  padding: const EdgeInsets.all(20),

                  child: Column(

                    children: [

                      const CircleAvatar(
                        radius: 55,
                        child: Icon(
                          Icons.person,
                          size: 60,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        user.email,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 30),

                      Card(

                        child: ListTile(
                          leading: const Icon(Icons.badge),
                          title: const Text("Role"),
                          subtitle: Text(user.role),
                        ),

                      ),

                      Card(

                        child: ListTile(
                          leading: const Icon(Icons.phone),
                          title: const Text("Nomor HP"),
                          subtitle: Text(
                            user.phone ?? "-",
                          ),
                        ),

                      ),

                      const SizedBox(height: 40),

                      SizedBox(

                        width: double.infinity,

                        child: ElevatedButton.icon(

                          icon: const Icon(Icons.logout),

                          label: const Text("Logout"),

                          onPressed: () async {

                            await auth.logout();

                            if (!context.mounted) return;

                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoutes.login,
                              (route) => false,
                            );

                          },

                        ),

                      ),

                    ],

                  ),

                ),

    );

  }

}