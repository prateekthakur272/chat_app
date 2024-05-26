import 'package:supabase/supabase.dart';

abstract class _BaseMessageRepository {
  Future<Map<String, dynamic>> createMessage(Map<String, dynamic> data);
  Future<List<Map<String, dynamic>>> fetchMessages(String roomId);
}

/// Message Repository
class MessageRepository extends _BaseMessageRepository {
  /// Constructor
  MessageRepository(SupabaseClient db) : _db = db;

  final SupabaseClient _db;

  @override
  Future<Map<String, dynamic>> createMessage(Map<String, dynamic> data) async {
    try {
      return await _db.from('messages').insert(data).select().single();
    } catch (err) {
      throw Exception(err);
    }
  }

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
