import 'package:supabase/supabase.dart';

abstract class _BaseMessageRepository {
  void createMessage();
  Future<List<Map<String, dynamic>>> fetchMessages(String roomId);
}

/// Message Repository
class MessageRepository extends _BaseMessageRepository {
  /// Constructor
  MessageRepository(SupabaseClient db) : _db = db;

  final SupabaseClient _db;

  @override
  void createMessage() {}

  @override
  Future<List<Map<String, dynamic>>> fetchMessages(String roomId) async {
    try {
      final messages =
          await _db.from('messages').select().eq('chat_room_id', roomId);
      return messages;
    } catch (err) {
      throw Exception(err);
    }
  }
}
