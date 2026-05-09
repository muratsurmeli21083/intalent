import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/app_models.dart';
import '../models/assessment_response.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  final SupabaseClient _client = Supabase.instance.client;

  // --- Profile Operations ---
  Future<UserProfile?> getProfile(String userId) async {
    final response = await _client.from('profiles').select().eq('id', userId).maybeSingle();
    return response != null ? UserProfile.fromJson(response) : null;
  }

  Future<void> updateProfile(UserProfile profile) async {
    await _client.from('profiles').upsert(profile.toJson());
  }

  // --- Job Operations ---
  Future<List<JobModel>> getJobs() async {
    final response = await _client.from('jobs').select();
    return response.map<JobModel>((json) => JobModel.fromJson(json)).toList();
  }

  // --- Assessment Operations ---
  Future<void> saveResponse(AssessmentResponse response) async {
    await _client.from('responses').insert(response.toJson());
  }

  Future<void> saveBulkResponses(List<AssessmentResponse> responses) async {
    final jsonList = responses.map((r) => r.toJson()).toList();
    await _client.from('responses').insert(jsonList);
  }

  Future<void> saveCompetencyScore(CompetencyScore score) async {
    await _client.from('scores').insert(score.toJson());
  }

  // --- Question Bank Operations ---
  Future<void> insert(String table, Map<String, dynamic> data) async {
    await _client.from(table).insert(data);
  }

  Future<List<QuestionModel>> getQuestions() async {
    final response = await _client.from('questions').select();
    return response.map<QuestionModel>((json) => QuestionModel.fromJson(json)).toList();
  }

  // --- Helpers ---
  User? get currentUser => _client.auth.currentUser;
}
