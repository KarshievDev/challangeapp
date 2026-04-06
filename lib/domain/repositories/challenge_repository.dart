import '../entities/challenge_entity.dart';
import '../entities/user_challenge_entity.dart';

abstract class ChallengeRepository {
  Future<List<ChallengeEntity>> getPublicChallenges(ChallengeCategory? category);
  Future<List<UserChallengeEntity>> getUserActiveChallenges(String userId);
  Future<void> joinChallenge(String userId, String challengeId);
  Future<void> checkIn(String userId, String challengeId, String proofURL, String? note);
  Future<List<Map<String, dynamic>>> getLeaderboard();
  Future<void> updateXP(String userId, int xp);
  Future<void> addBadges(String userId, String badgeId);
}
