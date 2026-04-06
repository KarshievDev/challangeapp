import 'dart:async';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  final _controller = StreamController<UserEntity?>();
  UserEntity? _cachedUser;

  @override
  Stream<UserEntity?> get user => _controller.stream;

  @override
  UserEntity? get currentUser => _cachedUser;

  @override
  Future<UserEntity?> signInWithEmail(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    _cachedUser = UserEntity(uid: 'mock_uid', email: email, displayName: 'Warrior Demo', xp: 450);
    _controller.add(_cachedUser);
    return _cachedUser;
  }

  @override
  Future<UserEntity?> signUpWithEmail(String email, String password) async {
    return signInWithEmail(email, password);
  }

  @override
  Future<UserEntity?> signInWithGoogle() async {
    return signInWithEmail('google@demo.com', '');
  }

  @override
  Future<UserEntity?> signInWithApple() async {
    return signInWithEmail('apple@demo.com', '');
  }

  @override
  Future<void> signOut() async {
    _cachedUser = null;
    _controller.add(null);
  }

  @override
  Future<void> deleteAccount() async {
    await signOut();
  }

  @override
  Future<void> updateProfile(UserEntity user) async {
    _cachedUser = user;
    _controller.add(user);
  }
  
  void init() {
    _controller.add(null);
  }
}
