import 'dart:async';
import 'dart:io';

import 'package:chat_server/src/repository/message_repository.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context, String id) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context, id);

    case HttpMethod.post:
    case HttpMethod.put:
    case HttpMethod.patch:
    case HttpMethod.delete:
    case HttpMethod.head:
    case HttpMethod.options:
      return Response(
        body: 'Method not allowed',
        statusCode: HttpStatus.methodNotAllowed,
      );
  }
}

FutureOr<Response> _get(RequestContext context, String id) async {
  final messageRepository = context.read<MessageRepository>();
  try {
    final messages = await messageRepository.fetchMessages(id);
    return Response.json(body: {'messages': messages});
  } catch (err) {
    return Response.json(
      statusCode: HttpStatus.internalServerError,
      body: {'error': err.toString()},
    );
  }
}
