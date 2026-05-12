import 'package:supabase_flutter/supabase_flutter.dart';

/// İkili Skorlama Motoru
/// - Journey Skoru: Adayın profil doluluk güvenilirliği (0-100)
/// - Match Skoru: İlana özel ağırlıklı yetkinlik uyumu (0-100)
class ScoringService {
  static final ScoringService _instance = ScoringService._internal();
  factory ScoringService() => _instance;
  ScoringService._internal();

  final SupabaseClient _client = Supabase.instance.client;

  // -----------------------------------------------
  // 1. JOURNEY SKORU (Supabase Function üzerinden)
  // -----------------------------------------------
  Future<double> getJourneyScore(String userId) async {
    try {
      final result = await _client.rpc(
        'calculate_journey_score',
        params: {'p_user_id': userId},
      );
      return (result as num?)?.toDouble() ?? 0.0;
    } catch (e) {
      // Fallback: lokal hesaplama
      return await _calculateJourneyScoreLocally(userId);
    }
  }

  /// Supabase RPC çalışmıyorsa lokal hesaplama (fallback)
  Future<double> _calculateJourneyScoreLocally(String userId) async {
    double score = 0;

    try {
      // Profil kontrolü
      final profile = await _client
          .from('profiles')
          .select('first_name, last_name, email')
          .eq('id', userId)
          .maybeSingle();

      if (profile != null) {
        if (profile['first_name'] != null) score += 20;
        if (profile['email'] != null) score += 10;
      }

      // Tamamlanan test sayısı
      final scores = await _client
          .from('scores')
          .select('competency_type')
          .eq('user_id', userId);

      final uniqueTypes = (scores as List)
          .map((s) => s['competency_type'] as String?)
          .where((t) => t != null)
          .toSet()
          .length;

      score += (uniqueTypes * 10).clamp(0, 70).toDouble();
    } catch (_) {}

    return score.clamp(0, 100);
  }

  // -----------------------------------------------
  // 2. MATCH SKORU (İlana özel ağırlıklı hesaplama)
  // -----------------------------------------------
  Future<double> getMatchScore(String userId, String jobId) async {
    try {
      final result = await _client.rpc(
        'calculate_match_score',
        params: {'p_user_id': userId, 'p_job_id': jobId},
      );
      return (result as num?)?.toDouble() ?? 0.0;
    } catch (e) {
      return await _calculateMatchScoreLocally(userId, jobId);
    }
  }

  /// Lokal Match Skoru hesaplama (fallback)
  Future<double> _calculateMatchScoreLocally(String userId, String jobId) async {
    try {
      // İlandaki katsayıları al
      final jobData = await _client
          .from('jobs')
          .select('weight_coefficients')
          .eq('id', jobId)
          .maybeSingle();

      if (jobData == null) return 0;

      final Map<String, dynamic> weights =
          (jobData['weight_coefficients'] as Map<String, dynamic>?) ?? {};

      if (weights.isEmpty) return 0;

      // Adayın yetkinlik skorlarını al
      final scoresData = await _client
          .from('scores')
          .select('competency_type, total_score')
          .eq('user_id', userId);

      final Map<String, double> candidateScores = {};
      for (final s in (scoresData as List)) {
        final type = s['competency_type'] as String?;
        final score = (s['total_score'] as num?)?.toDouble() ?? 0.0;
        if (type != null) candidateScores[type] = score;
      }

      // Ağırlıklı ortalama hesapla
      double weightedSum = 0;
      double totalWeight = 0;

      for (final entry in weights.entries) {
        final weight = (entry.value as num).toDouble();
        final candidateScore = candidateScores[entry.key] ?? 0.0;
        weightedSum += candidateScore * weight;
        totalWeight += weight;
      }

      if (totalWeight == 0) return 0;
      return (weightedSum / totalWeight).clamp(0, 100);
    } catch (_) {
      return 0;
    }
  }

  // -----------------------------------------------
  // 3. İK DASHBOARD - SIRALI ADAY LİSTESİ
  // -----------------------------------------------
  /// Bir ilan için adayları Match Skoru'na göre sıralı döner
  Future<List<RankedCandidate>> getRankedCandidatesForJob(String jobId) async {
    try {
      // Supabase RPC (en verimli yol)
      final result = await _client.rpc(
        'get_ranked_candidates_for_job',
        params: {'p_job_id': jobId},
      );
      return (result as List)
          .map((row) => RankedCandidate.fromJson(row))
          .toList();
    } catch (e) {
      // Fallback: tüm adayları çek, lokal hesapla
      return await _getRankedCandidatesLocally(jobId);
    }
  }

  Future<List<RankedCandidate>> _getRankedCandidatesLocally(String jobId) async {
    try {
      final candidates = await _client
          .from('profiles')
          .select('id, first_name, last_name, email, journey_score')
          .eq('role', 'candidate');

      List<RankedCandidate> ranked = [];
      for (final c in (candidates as List)) {
        final userId = c['id'] as String;
        final matchScore = await _calculateMatchScoreLocally(userId, jobId);
        final journeyScore = (c['journey_score'] as num?)?.toDouble()
            ?? await _calculateJourneyScoreLocally(userId);

        ranked.add(RankedCandidate(
          candidateId: userId,
          firstName: c['first_name'] ?? '',
          lastName: c['last_name'] ?? '',
          email: c['email'] ?? '',
          journeyScore: journeyScore,
          matchScore: matchScore,
        ));
      }

      // Match Skoru'na göre sırala (yüksekten düşüğe)
      ranked.sort((a, b) => b.matchScore.compareTo(a.matchScore));
      return ranked;
    } catch (_) {
      return [];
    }
  }

  // -----------------------------------------------
  // 4. SKOR KAYDET (Test tamamlandığında)
  // -----------------------------------------------
  Future<void> saveTestScore({
    required String userId,
    required String competencyType, // 'sayisal', 'liderlik' vb.
    required double score,
    String? taskId,
  }) async {
    try {
      await _client.from('scores').upsert({
        'user_id': userId,
        'competency_type': competencyType,
        'total_score': score,
        if (taskId != null) 'task_id': taskId,
        'competency_name': competencyType,
      }, onConflict: 'user_id,competency_type');
    } catch (_) {}
  }

  // -----------------------------------------------
  // 5. JOURNEY SKORU GÜNCELLE (Profil kaydında)
  // -----------------------------------------------
  Future<void> updateJourneyScore(String userId) async {
    try {
      final score = await getJourneyScore(userId);
      await _client
          .from('profiles')
          .update({'journey_score': score})
          .eq('id', userId);
    } catch (_) {}
  }
}

/// Sıralı Aday Modeli (İK Dashboard için)
class RankedCandidate {
  final String candidateId;
  final String firstName;
  final String lastName;
  final String email;
  final double journeyScore; // Güvenilirlik (profil doluluk)
  final double matchScore;   // İlana uygunluk (esas sıralama kriteri)

  const RankedCandidate({
    required this.candidateId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.journeyScore,
    required this.matchScore,
  });

  factory RankedCandidate.fromJson(Map<String, dynamic> json) => RankedCandidate(
    candidateId: json['candidate_id'] ?? json['id'] ?? '',
    firstName: json['first_name'] ?? '',
    lastName: json['last_name'] ?? '',
    email: json['email'] ?? '',
    journeyScore: (json['journey_score'] as num?)?.toDouble() ?? 0,
    matchScore: (json['match_score'] as num?)?.toDouble() ?? 0,
  );

  String get fullName => '$firstName $lastName'.trim();

  /// Journey Skoru'na göre güvenilirlik etiketi
  String get reliabilityBadge {
    if (journeyScore >= 90) return 'Tam Profil ✓';
    if (journeyScore >= 70) return 'Güvenilir';
    return 'Profil Eksik';
  }

  Color get reliabilityColor {
    if (journeyScore >= 90) return const Color(0xFF00C853);
    if (journeyScore >= 70) return const Color(0xFFFF9800);
    return const Color(0xFFE53935);
  }
}

// Color sınıfı için import (sadece reliabilityColor için)
import 'package:flutter/material.dart' show Color;
