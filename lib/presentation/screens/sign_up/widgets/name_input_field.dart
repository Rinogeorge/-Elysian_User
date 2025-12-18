import 'package:flutter/material.dart';

class NameInputField extends StatelessWidget {
  final TextEditingController? controller;

  const NameInputField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.name,
        decoration: const InputDecoration(
          hintText: 'Enter your name',
          hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}
