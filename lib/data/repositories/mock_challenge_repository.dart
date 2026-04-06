import '../../domain/entities/challenge_entity.dart';
import '../../domain/entities/user_challenge_entity.dart';
import '../../domain/repositories/challenge_repository.dart';

class MockChallengeRepository implements ChallengeRepository {
  @override
  Future<List<ChallengeEntity>> getPublicChallenges(ChallengeCategory? category) async {
    return [
      ChallengeEntity(id: '1', title: 'Early Bird', description: 'Wake at 5am', durationDays: 21, category: ChallengeCategory.mindset, totalXP: 100),
      ChallengeEntity(id: '2', title: 'Pushups Pro', description: '50 pushups daily', durationDays: 30, category: ChallengeCategory.health, totalXP: 200),
    ];
  }

  @override
  Future<List<UserChallengeEntity>> getUserActiveChallenges(String userId) async {
    return [
      UserChallengeEntity(challengeId: '1', userId: userId, startDate: DateTime.now().subtract(const Duration(days: 5)), currentStreak: 5, totalCheckins: 5),
    ];
  }

  @override
  Future<void> joinChallenge(String userId, String challengeId) async {}

  @override
  Future<void> checkIn(String userId, String challengeId, String proofURL, String? note) async {}

  @override
  Future<List<Map<String, dynamic>>> getLeaderboard() async {
    return [
      {'displayName': 'Pro Warrior', 'xp': 15000, 'photoURL': null},
      {'displayName': 'Habit Ninja', 'xp': 12000, 'photoURL': null},
      {'displayName': 'Consistent Cat', 'xp': 9000, 'photoURL': null},
    ];
  }

  @override
  Future<void> updateXP(String userId, int xp) async {}

  @override
  Future<void> addBadges(String userId, String badgeId) async {}
}
