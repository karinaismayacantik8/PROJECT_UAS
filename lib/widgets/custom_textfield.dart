import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool obscure = true;

  @override
  Widget build(BuildContext context) {

    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Text(
          widget.label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),

        const SizedBox(height: 8),

        TextFormField(

          controller: widget.controller,

          keyboardType: widget.keyboardType,

          validator: widget.validator,

          obscureText: widget.isPassword ? obscure : false,

          decoration: InputDecoration(

            hintText: widget.hint,

            prefixIcon: Icon(widget.icon),

            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      obscure
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                  )
                : null,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),

          ),

        ),

      ],

    );

  }

}