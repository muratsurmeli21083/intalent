import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/app_models.dart';
import '../models/assessment_response.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  final SupabaseClient client = Supabase.instance.client;

  // --- Auth Helpers ---
  User? get currentUser => client.auth.currentUser;

  // --- Profile Operations ---
  Future<UserProfile?> getProfile(String id) async {
    try {
      final response = await client.from('profiles').select().eq('id', id).maybeSingle();
      if (response == null) return null;
      return UserProfile.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateProfile(UserProfile profile) async {
    await client.from('profiles').update(profile.toJson()).eq('id', profile.id);
  }

  Future<List<UserProfile>> getAllCandidates() async {
    final response = await client.from('profiles').select().eq('role', 'candidate');
    return (response as List).map((json) => UserProfile.fromJson(json)).toList();
  }

  // --- Job Operations ---
  Future<List<JobModel>> getAllJobs() async {
    final response = await client.from('jobs').select();
    return (response as List).map((json) => JobModel.fromJson(json)).toList();
  }

  // --- Question Operations ---
  /// Tüm soruları çeker (task_id filtresi yok)
  Future<List<QuestionModel>> getQuestions() async {
    final response = await client.from('questions').select();
    return (response as List).map((json) => QuestionModel.fromJson(json)).toList();
  }

  /// Belirli bir task'a ait soruları çeker
  Future<List<QuestionModel>> getQuestionsByTaskId(String taskId) async {
    final response = await client.from('questions').select().eq('task_id', taskId);
    return (response as List).map((json) => QuestionModel.fromJson(json)).toList();
  }

  Future<void> insert(String table, Map<String, dynamic> data) async {
    await client.from(table).insert(data);
  }

  // --- Response & Score Operations ---
  Future<void> saveBulkResponses(List<AssessmentResponse> responses) async {
    // Kullanıcı yoksa sessizce atla
    if (currentUser == null) return;
    final data = responses.map((r) => r.toJson()).toList();
    await client.from('responses').insert(data);
  }

  Future<void> saveCompetencyScore(CompetencyScore score) async {
    if (currentUser == null) return;
    await client.from('scores').insert(score.toJson());
  }

  // --- Count Helpers ---
  Future<int> getCandidateCount() async {
    try {
      final response = await client.from('profiles').select('*').count(CountOption.exact);
      return response.count ?? 0;
    } catch (_) {
      return 0;
    }
  }

  Future<int> getJobCount() async {
    try {
      final response = await client.from('jobs').select('*').count(CountOption.exact);
      return response.count ?? 0;
    } catch (_) {
      return 0;
    }
  }
}
