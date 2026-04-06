import 'package:firebase_auth/firebase_auth.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> signInWithEmail(String email, String password);
  Future<UserEntity?> signUpWithEmail(String email, String password);
  Future<UserEntity?> signInWithGoogle();
  Future<UserEntity?> signInWithApple();
  Future<void> signOut();
  Future<void> deleteAccount();
  Stream<UserEntity?> get user;
  UserEntity? get currentUser;
  Future<void> updateProfile(UserEntity user);
}
