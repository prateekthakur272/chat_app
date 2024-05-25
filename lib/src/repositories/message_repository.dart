import 'dart:developer';

import 'package:chat_app/src/services/api_client.dart';
import 'package:models/models.dart';

class MessageRepository{
  final ApiClient _client;
  const MessageRepository({required ApiClient client}): _client = client;

  Future<List<Message>> getMessages(String chatRoomId) async {
    final response = await _client.get('http://localhost:8080/chat-rooms/$chatRoomId/messages');
    final messages = response['messages'] as List<dynamic>;
    log(messages.toString());
    return messages.map((message) => Message.fromJson(message)).toList();
  }
}