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
  final String? type;
  final String category;
  final String content;
  final String? imageUrl;
  final Map<String, dynamic> options;
  final String? correctAnswer;
  final String? dimensionId;
  final int points;

  QuestionModel({
    required this.id,
    this.tenantId,
    this.taskId,
    this.type,
    required this.category,
    required this.content,
    this.imageUrl,
    required this.options,
    this.correctAnswer,
    this.dimensionId,
    this.points = 1,
  });

  Map<String, dynamic> toJson() => {
    'tenant_id': tenantId,
    'task_id': taskId,
    'type': type,
    'category': category,
    'content': content,
    'image_url': imageUrl,
    'options': options,
    'correct_answer': correctAnswer,
    'dimension_id': dimensionId,
    'points': points,
  };

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
    id: json['id'],
    tenantId: json['tenant_id'],
    taskId: json['task_id'],
    type: json['type'],
    category: json['category'],
    content: json['content'],
    imageUrl: json['image_url'],
    options: json['options'],
    correctAnswer: json['correct_answer'],
    dimensionId: json['dimension_id'],
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
  final Map<String, dynamic>? weightCoefficients; // Yeni eklenen alan

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
    this.weightCoefficients, // Constructor'a eklendi
  });

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
    id: json["id"],
    tenantId: json["tenant_id"],
    title: json["title"],
    position: json["position"],
    city: json["city"],
    definition: json["definition"],
    logoUrl: json["logo_url"],
    requiredTests: List<String>.from(json["required_tests"] ?? []),
    requiredCompetencies: json["required_competencies"],
    weightCoefficients: json["weight_coefficients"], // fromJson'a eklendi
  );
}
