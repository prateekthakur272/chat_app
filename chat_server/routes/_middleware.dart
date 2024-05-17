import 'package:chat_server/src/repository/message_repository.dart';
import 'package:dart_frog/dart_frog.dart';

import '../main.dart';

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(provider<MessageRepository>((context) => messageRepository));
}
