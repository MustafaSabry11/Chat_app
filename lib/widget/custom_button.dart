import 'package:chat_app/widget/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  final String text;
  final Color color;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(Size(double.infinity, 50)),
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.pressed)) {
            return Colors.blue; // لما تدوس
          }
          return Colors.white; // الوضع العادي
        }),
      ),
      onPressed: onPressed,
      child: CustomText(text: text, color: Colors.black, fontSize: 16),
    );
  }
}
