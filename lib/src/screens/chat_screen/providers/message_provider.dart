import 'package:chat_app/main.dart';
import 'package:chat_app/src/repositories/message_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:models/models.dart';

class MessageProvider extends ChangeNotifier {
  final MessageRepository _repository;
  MessageProvider(MessageRepository repository) : _repository = repository;

  List<Message> _messages = [];
  List<Message> get messages => _messages;

  void update(String chatRoomId) async {
    _messages = await _repository.getMessages(chatRoomId) + localMessages;
    _messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    notifyListeners();
  }

  void listen(String chatRoomId) {
    _repository.connect();
    _repository.subscribeToMessageUpdates((message) {
      final newMessage = Message.fromJson(message);
      _messages.add(newMessage);
    });
    notifyListeners();
  }

  void send(String content, chatRoomId) async {
    final message = Message(
      content: content,
        chatRoomId: chatRoomId,
        senderUserId: userId1,
        receiverUserId: userId2,
        createdAt: DateTime.now());
    _messages.add(message);
    await _repository.createMessage(message);
    notifyListeners();
  }
}

enum MessageEvents{
  create,
}