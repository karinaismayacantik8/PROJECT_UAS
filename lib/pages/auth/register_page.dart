import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../core/utils/validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> register() async {

    if (!_formKey.currentState!.validate()) return;

    if (passwordController.text !=
        confirmPasswordController.text) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Konfirmasi password tidak sama"),
        ),
      );

      return;
    }

    final auth = context.read<AuthProvider>();

    final success = await auth.register(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (!mounted) return;

    if (success) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registrasi berhasil"),
        ),
      );

      Navigator.pop(context);

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            auth.errorMessage ?? "Registrasi gagal",
          ),
        ),
      );

    }

  }

  @override
  Widget build(BuildContext context) {

    final auth = context.watch<AuthProvider>();

    return Scaffold(

      appBar: AppBar(
        title: const Text("Register"),
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(24),

          child: Form(

            key: _formKey,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [

                const SizedBox(height: 20),

                const Icon(
                  Icons.person_add,
                  size: 90,
                ),

                const SizedBox(height: 20),

                const Center(
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                const Center(
                  child: Text(
                    "Daftar untuk mulai berbelanja",
                  ),
                ),

                const SizedBox(height: 40),

                CustomTextField(
                  controller: nameController,
                  label: "Nama",
                  hint: "Masukkan nama lengkap",
                  icon: Icons.person,
                  validator: Validator.validateName,
                ),

                const SizedBox(height: 20),

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

                const SizedBox(height: 20),

                CustomTextField(
                  controller: confirmPasswordController,
                  label: "Konfirmasi Password",
                  hint: "Ulangi password",
                  icon: Icons.lock_outline,
                  isPassword: true,
                  validator: Validator.validatePassword,
                ),

                const SizedBox(height: 30),

                CustomButton(
                  text: "REGISTER",
                  loading: auth.isLoading,
                  onPressed: register,
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Text("Sudah punya akun?"),

                    TextButton(

                      onPressed: () {

                        Navigator.pop(context);

                      },

                      child: const Text("Login"),

                    )

                  ],
                )

              ],

            ),

          ),

        ),

      ),

    );

  }

}