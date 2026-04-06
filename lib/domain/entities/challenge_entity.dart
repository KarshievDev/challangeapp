import 'package:equatable/equatable.dart';

enum ChallengeCategory {
  health,
  mindset,
  skills,
  community,
}

class ChallengeEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final int durationDays;
  final ChallengeCategory category;
  final String? imageURL;
  final int totalXP;
  final bool isPublic;
  final DateTime? createdAt;

  const ChallengeEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.durationDays,
    required this.category,
    this.imageURL,
    this.totalXP = 50,
    this.isPublic = true,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, title, description, durationDays, category, imageURL, totalXP, isPublic, createdAt];
}
