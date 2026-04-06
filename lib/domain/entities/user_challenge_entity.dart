import 'package:equatable/equatable.dart';

class UserChallengeEntity extends Equatable {
  final String challengeId;
  final String userId;
  final DateTime startDate;
  final DateTime? endDate;
  final int currentStreak;
  final int totalCheckins;
  final List<CheckInDetailEntity> checkins;
  final bool isCompleted;

  const UserChallengeEntity({
    required this.challengeId,
    required this.userId,
    required this.startDate,
    this.endDate,
    this.currentStreak = 0,
    this.totalCheckins = 0,
    this.checkins = const [],
    this.isCompleted = false,
  });

  @override
  List<Object?> get props => [challengeId, userId, startDate, endDate, currentStreak, totalCheckins, checkins, isCompleted];

  int get progressPercentage {
    // Assuming we calculate it based on a 7/21/30 day duration from challenge.
    // We would need the challenge data to calculate this perfectly, but let's assume we store target.
    return 0; // Placeholder
  }
}

class CheckInDetailEntity extends Equatable {
  final DateTime timestamp;
  final String proofURL;
  final String? note;

  const CheckInDetailEntity({
    required this.timestamp,
    required this.proofURL,
    this.note,
  });

  @override
  List<Object?> get props => [timestamp, proofURL, note];
}
