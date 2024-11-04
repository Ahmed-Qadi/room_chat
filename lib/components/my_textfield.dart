import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String? label;
  final bool isPassword;
  final String? hint;

  final double radius;

  final TextEditingController controller;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final Widget? prefixIcon;

  const MyTextField(
      {super.key,
      required this.radius,
      this.hint,
      this.label,
      required this.isPassword,
      this.prefixIcon,
      required this.controller,
      this.suffixIcon,
      required this.keyboardType,
       });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        keyboardType: keyboardType,
        obscureText: isPassword,
        controller: controller,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintText: hint,
            labelText: label,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius)),
            labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
            fillColor: Theme.of(context).colorScheme.secondary,
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary)),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary))),
      ),
    );
  }
}
