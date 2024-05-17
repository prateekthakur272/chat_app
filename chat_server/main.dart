import 'dart:io';

import 'package:chat_server/src/config/env.dart';
import 'package:chat_server/src/repository/message_repository.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:supabase/supabase.dart';

late MessageRepository messageRepository;
Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  final db = SupabaseClient(Env.SUPERBASE_URL, Env.SUPERBASE_SERVICE_ROLE_KEY);
  messageRepository = MessageRepository(db);
  return serve(handler, ip, port);
}
