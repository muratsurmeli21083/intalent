class AssessmentResponse {
  final String? userId;
  final String questionId;
  final int points;
  final DateTime createdAt;

  AssessmentResponse({
    this.userId,
    required this.questionId,
    required this.points,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'question_id': questionId,
      'points': points,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory AssessmentResponse.fromJson(Map<String, dynamic> json) {
    return AssessmentResponse(
      userId: json['user_id'],
      questionId: json['question_id'],
      points: json['points'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
