import 'package:chat_app/src/screens/chat_screen/widgets/avatar.dart';
import 'package:chat_app/src/screens/chat_screen/widgets/message_bar.dart';
import 'package:chat_app/src/shared/strings.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:triton_extensions/triton_extensions.dart';

class ChatScreen extends StatelessWidget {
  final ChatRoom chatRoom;
  const ChatScreen({super.key, required this.chatRoom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          PopupMenuButton<String>(
              itemBuilder: (context) => const [
                    PopupMenuItem(child: Text('View Profile')),
                    PopupMenuItem(child: Text('Clear Chat')),
                    PopupMenuItem(child: Text('Delete Chat')),
                  ])
        ],
        title: Row(
          children: [
            const Avatar(
              radius: 24,
              imgUrl:
                  'https://t3.ftcdn.net/jpg/05/19/32/56/360_F_519325685_Wy96q7w50hNTxNjTUYyQbkQnSmHIQxjv.jpg',
            ),
            8.space,
            const Text(chatRoomText),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(child: Container()),
          const MessageBar()
        ],
      ),
    );
  }
}
