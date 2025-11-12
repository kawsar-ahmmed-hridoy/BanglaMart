import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const AuthButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = Colors.blue, // default color
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
