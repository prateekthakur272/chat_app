import 'package:chat_app/src/app.dart';
import 'package:chat_app/src/repositories/message_repository.dart';
import 'package:chat_app/src/screens/chat_screen/providers/message_provider.dart';
import 'package:chat_app/src/services/api_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:models/models.dart';
import 'package:provider/provider.dart';

final apiClient = ApiClient(tokenProvider: () async {
  return '';
});

final messageRepository = MessageRepository(client: apiClient);
final messageProvider = MessageProvider(messageRepository);

void main() {
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => messageProvider, child: const App()));
}

const userId1 = '33f771e2-311b-4d4f-9b14-d1e1c59936d3';
const userId2 = '94a6b01e-319e-494e-b454-98f22ab0d109';

final chatRoom = ChatRoom(
  id: '8d162274-6cb8-4776-815a-8e721ebfb76d',
  participants: const [
    User(
      id: userId1,
      username: 'User 1',
      phone: '1234512345',
      email: 'user1@email.com',
      avatarUrl:
          'https://images.unsplash.com/photo-1700493624764-f7524969037d?q=80&w=3570&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      status: 'online',
    ),
    User(
      id: userId2,
      username: 'User 2',
      phone: '5432154321',
      email: 'user2@email.com',
      avatarUrl:
          'https://images.unsplash.com/photo-1700469880511-3ef0cee47985?q=80&w=3672&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      status: 'online',
    ),
  ],
  lastMessage: Message(
    id: 'de120f3a-dbca-4330-9e2e-18b55a2fb9e5',
    chatRoomId: '8d162274-6cb8-4776-815a-8e721ebfb76d',
    senderUserId: userId1,
    receiverUserId: userId2,
    content: 'Hey! I am good, thanks.',
    createdAt: DateTime(2023, 12, 1, 1, 0, 0),
  ),
  unreadCount: 0,
);

final localMessages = [
  Message(
    id: 'de120f3a-dbca-4330-9e2e-18b55a2fb9e6',
    chatRoomId: '8d162274-6cb8-4776-815a-8e721ebfb76f',
    senderUserId: userId1,
    receiverUserId: userId2,
    content: 'How are you???',
    createdAt: DateTime(2023, 12, 1, 0, 0, 0),
  ),
  Message(
    id: 'de120f3a-dbca-4330-9e2e-18b55a2fb9e7',
    chatRoomId: '8d162274-6cb8-4776-815a-8e721ebfb76f',
    senderUserId: userId2,
    receiverUserId: userId1,
    content: 'Hey! I am good, thanks.',
    createdAt: DateTime(2023, 12, 1, 1, 0, 0),
  ),
];
