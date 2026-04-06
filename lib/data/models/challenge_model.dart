import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/challenge_entity.dart';

class ChallengeModel extends ChallengeEntity {
  const ChallengeModel({
    required String id,
    required String title,
    required String description,
    required int durationDays,
    required ChallengeCategory category,
    String? imageURL,
    int totalXP = 50,
    bool isPublic = true,
    DateTime? createdAt,
  }) : super(
          id: id,
          title: title,
          description: description,
          durationDays: durationDays,
          category: category,
          imageURL: imageURL,
          totalXP: totalXP,
          isPublic: isPublic,
          createdAt: createdAt,
        );

  factory ChallengeModel.fromSnapshot(DocumentSnapshot snap) {
    var data = snap.data() as Map<String, dynamic>;
    return ChallengeModel(
      id: snap.id,
      title: data['title'],
      description: data['description'],
      durationDays: data['durationDays'],
      category: ChallengeCategory.values.firstWhere((e) => e.name == data['category']),
      imageURL: data['imageURL'],
      totalXP: data['totalXP'] ?? 50,
      isPublic: data['isPublic'] ?? true,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'durationDays': durationDays,
      'category': category.name,
      'imageURL': imageURL,
      'totalXP': totalXP,
      'isPublic': isPublic,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
    };
  }
}
