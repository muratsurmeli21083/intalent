import 'package:supabase_flutter/supabase_flutter.dart';

class UserProfile {
  final String id;
  final String? tenantId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String role;
  final String? currentProgressTaskId;

  UserProfile({
    required this.id,
    this.tenantId,
    this.firstName,
    this.lastName,
    this.email,
    this.role = 'candidate',
    this.currentProgressTaskId,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'tenant_id': tenantId,
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'role': role,
    'current_progress_task_id': currentProgressTaskId,
  };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json['id'],
    tenantId: json['tenant_id'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    email: json['email'],
    role: json['role'] ?? 'candidate',
    currentProgressTaskId: json['current_progress_task_id'],
  );
}

class CompetencyScore {
  final String id;
  final String userId;
  final String? tenantId;
  final String taskId;
  final String competencyName;
  final double score;
  final double consistencyIndex;

  CompetencyScore({
    required this.id,
    required this.userId,
    this.tenantId,
    required this.taskId,
    required this.competencyName,
    required this.score,
    required this.consistencyIndex,
  });

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'tenant_id': tenantId,
    'task_id': taskId,
    'competency_name': competencyName,
    'score': score,
    'consistency_index': consistencyIndex,
  };

  factory CompetencyScore.fromJson(Map<String, dynamic> json) => CompetencyScore(
    id: json['id'],
    userId: json['user_id'],
    tenantId: json['tenant_id'],
    taskId: json['task_id'],
    competencyName: json['competency_name'],
    score: (json['score'] as num).toDouble(),
    consistencyIndex: (json['consistency_index'] as num).toDouble(),
  );
}

class QuestionModel {
  final String id;
  final String? tenantId;
  final String? taskId;
  final String category;
  final String content;
  final Map<String, dynamic> options;
  final String correctAnswer;
  final int points;

  QuestionModel({
    required this.id,
    this.tenantId,
    this.taskId,
    required this.category,
    required this.content,
    required this.options,
    required this.correctAnswer,
    this.points = 1,
  });

  Map<String, dynamic> toJson() => {
    'tenant_id': tenantId,
    'task_id': taskId,
    'category': category,
    'content': content,
    'options': options,
    'correct_answer': correctAnswer,
    'points': points,
  };

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
    id: json['id'],
    tenantId: json['tenant_id'],
    taskId: json['task_id'],
    category: json['category'],
    content: json['content'],
    options: json['options'],
    correctAnswer: json['correct_answer'] ?? '',
    points: json['points'] ?? 1,
  );
}

class JobModel {
  final String id;
  final String? tenantId;
  final String title;
  final String? position;
  final String? city;
  final String? definition;
  final String? logoUrl;
  final List<String>? requiredTests;
  final Map<String, dynamic>? requiredCompetencies;

  JobModel({
    required this.id,
    this.tenantId,
    required this.title,
    this.position,
    this.city,
    this.definition,
    this.logoUrl,
    this.requiredTests,
    this.requiredCompetencies,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
    id: json['id'],
    tenantId: json['tenant_id'],
    title: json['title'],
    position: json['position'],
    city: json['city'],
    definition: json['definition'],
    logoUrl: json['logo_url'],
    requiredTests: List<String>.from(json['required_tests'] ?? []),
    requiredCompetencies: json['required_competencies'],
  );
}
