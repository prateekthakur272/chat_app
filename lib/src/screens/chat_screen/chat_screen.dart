import 'package:chat_app/main.dart';
import 'package:chat_app/src/screens/chat_screen/providers/message_provider.dart';
import 'package:chat_app/src/screens/chat_screen/widgets/avatar.dart';
import 'package:chat_app/src/screens/chat_screen/widgets/message_bar.dart';
import 'package:chat_app/src/screens/chat_screen/widgets/message_bubble.dart';
import 'package:chat_app/src/shared/strings.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:provider/provider.dart';
import 'package:triton_extensions/triton_extensions.dart';

class ChatScreen extends StatefulWidget {
  final ChatRoom chatRoom;
  const ChatScreen({super.key, required this.chatRoom});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<MessageProvider>(context, listen: false).update(chatRoom.id);
  }

  @override
  Widget build(BuildContext context) {
    final currentParticipant =
        widget.chatRoom.participants.firstWhere((user) => user.id == userId1);
    final otherUser = widget.chatRoom.participants
        .firstWhere((user) => user.id != currentParticipant.id);

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
          Expanded(
              child: Consumer<MessageProvider>(
                builder: (context, ref, child) {
                  return ListView.builder(
                    padding: 8.padding,
                      itemCount: ref.messages.length,
                      itemBuilder: (context, index) =>
                          MessageBubble(message: ref.messages[index]));
                }
              )),
          const MessageBar()
        ],
      ),
    );
  }
}
