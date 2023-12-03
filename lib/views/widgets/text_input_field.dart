// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tiktok_clone/constants/constants.dart';

class TextInputField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final bool isObscure;
  final TextEditingController controller;
  const TextInputField({
    Key? key,
    required this.labelText,
    required this.icon,
    this.isObscure = false,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(labelText),
        prefixIcon: Icon(icon),
        labelStyle: const TextStyle(fontSize: 20),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: borderColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: borderColor)),
      ),
      obscureText: isObscure,
    );
  }
}
