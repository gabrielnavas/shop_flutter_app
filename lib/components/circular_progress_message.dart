import 'package:flutter/material.dart';
import 'package:shop_flutter_app/components/center_message.dart';

class CircularProgressMessage extends StatelessWidget {
  final String message;
  const CircularProgressMessage(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          child: CenterMessage(message),
        ),
        const CircularProgressIndicator(),
      ],
    );
  }
}
