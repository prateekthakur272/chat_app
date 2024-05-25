import 'package:chat_app/src/screens/chat_screen/widgets/message_box.dart';
import 'package:flutter/material.dart';

class MessageBar extends StatelessWidget {
  const MessageBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.attach_file)),
        const MessageBox(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.send),),
      ],
    );
  }
}


