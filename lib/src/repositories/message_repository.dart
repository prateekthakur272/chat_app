import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:chat_app/src/screens/chat_screen/providers/message_provider.dart';
import 'package:chat_app/src/services/api_client.dart';
import 'package:chat_app/src/services/websocket_client.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';

class MessageRepository {
  final ApiClient _client;
  final WebSocketClient _webSocketClient;
  late StreamSubscription? messageSubscription;
  late final StreamController<Map<String, dynamic>> messageController;

  MessageRepository(
      {required WebSocketClient webSocketClient, required ApiClient client})
      : _client = client,
        _webSocketClient = webSocketClient {
    _initializeControllers();
  }

  void _initializeControllers() {
    messageController = StreamController<Map<String, dynamic>>.broadcast();
  }

  Future<List<Message>> getMessages(String chatRoomId) async {
    final response = await _client
        .get('http://localhost:8080/chat-rooms/$chatRoomId/messages');
    final messages = response['messages'] as List<dynamic>;
    log(messages.toString());
    return messages.map((message) => Message.fromJson(message)).toList();
  }

  Future<void> createMessage(Message message) async {
    var payload = {'event': MessageEvents.create, 'data': message.toJson()};
    _webSocketClient.send(jsonEncode(payload));
  }

  void connect() {
    _webSocketClient.connect('ws://localhost:8080/ws', {
      'Authorization': 'Bearer ....',
    }, (channel) {
      channel.stream.listen(
        (event) {
          Map<String, dynamic> message = jsonDecode(event);
          if (message['event'] == MessageEvents.create) {
            messageController.add(message['data']);
          }
        },
        onDone: () {
          debugPrint('Connection closed');
        },
        onError: (error) {
          debugPrint('Error: $error');
        },
      );
    });
  }

  StreamSubscription subscribeToMessageUpdates(
    void Function(Map<String, dynamic>) onMessageReceived,
  ) {
    messageSubscription = _webSocketClient.channel!.stream.listen((event) {
      onMessageReceived(event);
    });
    return messageSubscription!;
  }

  void unsubscribeFromMessageUpdates() {
    messageSubscription?.cancel();
    messageSubscription = null;
  }
}
