import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoURL;
  final String? bio;
  final int xp;
  final List<String> interests;
  final List<String> badges;
  final Map<String, dynamic>? goals;

  const UserEntity({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoURL,
    this.bio,
    this.xp = 0,
    this.interests = const [],
    this.badges = const [],
    this.goals,
  });

  @override
  List<Object?> get props => [uid, email, displayName, photoURL, bio, xp, interests, badges, goals];

  UserEntity copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoURL,
    String? bio,
    int? xp,
    List<String>? interests,
    List<String>? badges,
    Map<String, dynamic>? goals,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      bio: bio ?? this.bio,
      xp: xp ?? this.xp,
      interests: interests ?? this.interests,
      badges: badges ?? this.badges,
      goals: goals ?? this.goals,
    );
  }
}
