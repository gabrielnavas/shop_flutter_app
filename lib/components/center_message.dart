import 'package:flutter/material.dart';

class CenterMessage extends StatelessWidget {
  final String message;
  const CenterMessage(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 23,
          color: Colors.black54,
        ),
      ),
    );
  }
}
