import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/challenge_entity.dart';
import '../../domain/entities/user_challenge_entity.dart';
import '../../domain/repositories/challenge_repository.dart';
import '../models/challenge_model.dart';

class ChallengeRepositoryImpl implements ChallengeRepository {
  final FirebaseFirestore _firestore;

  ChallengeRepositoryImpl({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<ChallengeEntity>> getPublicChallenges(ChallengeCategory? category) async {
    Query query = _firestore.collection('challenges').where('isPublic', isEqualTo: true);
    if (category != null) {
      query = query.where('category', isEqualTo: category.name);
    }
    var snapshot = await query.get();
    return snapshot.docs.map((doc) => ChallengeModel.fromSnapshot(doc)).toList();
  }

  @override
  Future<List<UserChallengeEntity>> getUserActiveChallenges(String userId) async {
    var snapshot = await _firestore.collection('user_challenges')
        .where('userId', isEqualTo: userId)
        .where('isCompleted', isEqualTo: false)
        .get();
    return snapshot.docs.map((doc) {
      var data = doc.data();
      return UserChallengeEntity(
        challengeId: data['challengeId'],
        userId: data['userId'],
        startDate: (data['startDate'] as Timestamp).toDate(),
        currentStreak: data['currentStreak'] ?? 0,
        totalCheckins: data['totalCheckins'] ?? 0,
        isCompleted: data['isCompleted'] ?? false,
      );
    }).toList();
  }

  @override
  Future<void> joinChallenge(String userId, String challengeId) async {
    await _firestore.collection('user_challenges').add({
      'userId': userId,
      'challengeId': challengeId,
      'startDate': FieldValue.serverTimestamp(),
      'currentStreak': 0,
      'totalCheckins': 0,
      'isCompleted': false,
    });
  }

  @override
  Future<void> checkIn(String userId, String challengeId, String proofURL, String? note) async {
    // Implementing a check-in logic: updating user_challenges record.
    // In a real app, this should probably be a Cloud Function for streak calculation.
    var doc = await _firestore.collection('user_challenges')
        .where('userId', isEqualTo: userId)
        .where('challengeId', isEqualTo: challengeId)
        .limit(1).get();
        
    if (doc.docs.isNotEmpty) {
      var ref = doc.docs.first.reference;
      await ref.update({
        'totalCheckins': FieldValue.increment(1),
        'currentStreak': FieldValue.increment(1), // Simple streak increment for now
        'checkins': FieldValue.arrayUnion([{
          'timestamp': Timestamp.now(),
          'proofURL': proofURL,
          'note': note,
        }])
      });
      await updateXP(userId, 10); // Simple XP increment
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getLeaderboard() async {
    var snapshot = await _firestore.collection('users')
        .orderBy('xp', descending: true)
        .limit(20).get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<void> updateXP(String userId, int xp) async {
    await _firestore.collection('users').doc(userId).update({
      'xp': FieldValue.increment(xp),
    });
  }

  @override
  Future<void> addBadges(String userId, String badgeId) async {
    await _firestore.collection('users').doc(userId).update({
      'badges': FieldValue.arrayUnion([badgeId]),
    });
  }
}
