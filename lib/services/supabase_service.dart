import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  final SupabaseClient _client = Supabase.instance.client;

  // Generic Insert
  Future<void> insert(String table, Map<String, dynamic> data) async {
    try {
      await _client.from(table).insert(data);
    } catch (e) {
      print('Supabase Insert Error: $e');
      rethrow;
    }
  }

  // Generic Select
  Future<List<Map<String, dynamic>>> select(String table, {String? userId}) async {
    try {
      var query = _client.from(table).select();
      if (userId != null) {
        query = query.eq('user_id', userId) as PostgrestFilterBuilder<List<Map<String, dynamic>>>;
      }
      return await query;
    } catch (e) {
      print('Supabase Select Error: $e');
      rethrow;
    }
  }

  // Authentication status
  User? get currentUser => _client.auth.currentUser;
}
