import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: IconButton(icon: const Icon(Icons.emoji_emotions_outlined), onPressed: () {},),
                contentPadding:
                const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                hintText: 'Type Message'),
          ),
        ));
  }
}
