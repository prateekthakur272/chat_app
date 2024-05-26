import 'dart:convert';

import 'package:chat_server/src/repository/message_repository.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';

Future<Response> onRequest(RequestContext context) async {
  final messageRepository = context.read<MessageRepository>();
  final handler = webSocketHandler((channel, protocol) {
    channel.stream.listen((message) {
      if (message is! String) {
        channel.sink.add('Invalid message');
        return;
      }

      final messageJson =
          jsonDecode(message) as Map<String, dynamic>;

      final event = messageJson['event'];
      final data = messageJson['data'] as Map<String,dynamic>;
      print('Data');
      print('event: $event, data: $data');
      switch (event) {
        case 'message.create':
          messageRepository.createMessage(data).then(
            (message) {
              channel.sink.add(
                jsonEncode({
                  'event': 'message.create',
                  'data': message,
                }),
              );
            },
          ).catchError((err) {
            print('Something went wrong');
          });
        default:
      }
    });
  });
  return handler(context);
}
