import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String uid,
    required String email,
    String? displayName,
    String? photoURL,
    String? bio,
    int xp = 0,
    List<String> interests = const [],
    List<String> badges = const [],
    Map<String, dynamic>? goals,
  }) : super(
          uid: uid,
          email: email,
          displayName: displayName,
          photoURL: photoURL,
          bio: bio,
          xp: xp,
          interests: interests,
          badges: badges,
          goals: goals,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var data = snap.data() as Map<String, dynamic>;
    return UserModel(
      uid: snap.id,
      email: data['email'],
      displayName: data['displayName'],
      photoURL: data['photoURL'],
      bio: data['bio'],
      xp: data['xp'] ?? 0,
      interests: List<String>.from(data['interests'] ?? []),
      badges: List<String>.from(data['badges'] ?? []),
      goals: data['goals'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'bio': bio,
      'xp': xp,
      'interests': interests,
      'badges': badges,
      'goals': goals,
    };
  }

  static UserModel fromEntity(UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      email: entity.email,
      displayName: entity.displayName,
      photoURL: entity.photoURL,
      bio: entity.bio,
      xp: entity.xp,
      interests: entity.interests,
      badges: entity.badges,
      goals: entity.goals,
    );
  }
}
