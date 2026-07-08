import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/app_routes.dart';
import '../../core/utils/validator.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {

    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthProvider>();

    final success = await auth.login(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (!mounted) return;

    if (success) {

      Navigator.pushReplacementNamed(
        context,
        AppRoutes.customerDashboard,
      );

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            auth.errorMessage ?? "Login gagal",
          ),
        ),
      );

    }

  }

  @override
  Widget build(BuildContext context) {

    final auth = context.watch<AuthProvider>();

    return Scaffold(

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(24),

          child: Form(

            key: _formKey,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [

                const SizedBox(height: 60),

                const Icon(
                  Icons.shopping_bag,
                  size: 90,
                ),

                const SizedBox(height: 20),

                const Center(
                  child: Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                const Center(
                  child: Text(
                    "Login untuk melanjutkan belanja favoritmu",
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 40),

                CustomTextField(
                  controller: emailController,
                  label: "Email",
                  hint: "Masukkan email",
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validator.validateEmail,
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  controller: passwordController,
                  label: "Password",
                  hint: "Masukkan password",
                  icon: Icons.lock,
                  isPassword: true,
                  validator: Validator.validatePassword,
                ),

                const SizedBox(height: 30),

                CustomButton(
                  text: "LOGIN",
                  loading: auth.isLoading,
                  onPressed: login,
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Text(
                      "Belum punya akun?",
                    ),

                    TextButton(

                      onPressed: () {

                        Navigator.pushNamed(
                          context,
                          AppRoutes.register,
                        );

                      },

                      child: const Text(
                        "Register",
                      ),

                    ),

                  ],
                ),

              ],

            ),

          ),

        ),

      ),

    );

  }

}