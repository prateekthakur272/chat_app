import 'dart:developer';

import 'package:chat_app/src/screens/chat_screen/providers/message_provider.dart';
import 'package:chat_app/src/screens/chat_screen/widgets/message_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageBar extends StatelessWidget {
  const MessageBar({super.key});

  @override
  Widget build(BuildContext context) {
    final messageProvider = Provider.of<MessageProvider>(context, listen: false);
    final messageController = TextEditingController();
    return Row(
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.attach_file)),
        MessageBox(controller: messageController,),
        IconButton(onPressed: () {
          messageProvider.send(messageController.text.trim(), 'chatRoomId');
          messageController.clear();
        }, icon: const Icon(Icons.send),),
      ],
    );
  }
}
