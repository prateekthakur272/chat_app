import 'package:chat_app/main.dart';
import 'package:chat_app/src/screens/chat_screen/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:triton_extensions/triton_extensions.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  const MessageBubble({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    const user = userId1;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Align(
        alignment: user == message.senderUserId
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: UnconstrainedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(user != message.senderUserId)
              const Avatar(
                radius: 14,
                imgUrl:
                    'https://t3.ftcdn.net/jpg/05/19/32/56/360_F_519325685_Wy96q7w50hNTxNjTUYyQbkQnSmHIQxjv.jpg',
              ),
              Container(
                  padding: 8.padding,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: user == message.senderUserId
                          ? context.colorScheme.primary.withOpacity(0.3)
                          : context.colorScheme.primary),
                  child: Column(
                    crossAxisAlignment : user == message.senderUserId
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.content ?? '',
                        style: TextStyle(
                            color: user == message.senderUserId
                                ? context.colorScheme.onSurface
                                : context.colorScheme.onPrimary,
                            fontSize: 16),
                      ),
                      // Text(
                      //   message.createdAt.toString(),
                      //   style: TextStyle(
                      //       color: user == message.senderUserId
                      //           ? context.colorScheme.onSurface
                      //           : context.colorScheme.onPrimary,
                      //       fontSize: 10),
                      // ),
                    ],
                  )),
              if(user == message.senderUserId)
                const Avatar(
                  radius: 14,
                  imgUrl:
                  'https://t3.ftcdn.net/jpg/05/19/32/56/360_F_519325685_Wy96q7w50hNTxNjTUYyQbkQnSmHIQxjv.jpg',
                ),
            ],
          ),
        ),
      ),
    );
  }
}
