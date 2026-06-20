import 'package:chat_app/constans.dart';
import 'package:flutter/material.dart';

class CustomFromTextField extends StatelessWidget {
  final String hintText;
  final TextInputType input;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  const CustomFromTextField({
    super.key,
    required this.input,
    required this.hintText,
    required this.obscureText,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      keyboardType: input,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white, fontSize: 16),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }
}
