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
    final response = await client.from('profiles').select().eq('id', id).single();
    return UserProfile.fromJson(response);
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
  Future<List<JobModel>> getAllQuestions() async {
    final response = await client.from('questions').select();
    return (response as List).map((json) => JobModel.fromJson(json)).toList();
  }

  Future<void> insert(String table, Map<String, dynamic> data) async {
    await client.from(table).insert(data);
  }

  // --- Response & Score Operations ---
  Future<void> saveBulkResponses(List<AssessmentResponse> responses) async {
    final data = responses.map((r) => r.toJson()).toList();
    await client.from('responses').insert(data);
  }

  Future<void> saveCompetencyScore(CompetencyScore score) async {
    await client.from('scores').insert(score.toJson());
  }

  // --- Count Helpers (The ONLY safe way for multiple Supabase versions) ---
  Future<int> getCandidateCount() async {
    final response = await client
        .from('profiles')
        .select('*')
        .count(CountOption.exact);
    return response.count ?? 0;
  }

  Future<int> getJobCount() async {
    final response = await client
        .from('jobs')
        .select('*')
        .count(CountOption.exact);
    return response.count ?? 0;
  }
}
