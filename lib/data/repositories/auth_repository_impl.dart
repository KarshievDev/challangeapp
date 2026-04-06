import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthRepositoryImpl implements AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl({
    firebase_auth.FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
    GoogleSignIn? googleSignIn,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance,
       _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  Stream<UserEntity?> get user {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;
      var snap = await _firestore.collection('users').doc(firebaseUser.uid).get();
      if (snap.exists) {
        return UserModel.fromSnapshot(snap);
      }
      return UserEntity(uid: firebaseUser.uid, email: firebaseUser.email ?? "");
    });
  }

  @override
  UserEntity? get currentUser {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return UserEntity(uid: user.uid, email: user.email ?? "");
  }

  @override
  Future<UserEntity?> signInWithEmail(String email, String password) async {
    var cred = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    if (cred.user != null) {
      var snap = await _firestore.collection('users').doc(cred.user!.uid).get();
      if (snap.exists) return UserModel.fromSnapshot(snap);
    }
    return null;
  }

  @override
  Future<UserEntity?> signUpWithEmail(String email, String password) async {
    var cred = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    if (cred.user != null) {
      var newUser = UserModel(uid: cred.user!.uid, email: email);
      await _firestore.collection('users').doc(cred.user!.uid).set(newUser.toJson());
      return newUser;
    }
    return null;
  }

  @override
  Future<UserEntity?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;
    final googleAuth = await googleUser.authentication;
    final cred = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    var userCred = await _firebaseAuth.signInWithCredential(cred);
    if (userCred.user != null) {
      var snap = await _firestore.collection('users').doc(userCred.user!.uid).get();
      if (!snap.exists) {
        var newUser = UserModel(uid: userCred.user!.uid, email: userCred.user!.email!, displayName: userCred.user!.displayName, photoURL: userCred.user!.photoURL);
        await _firestore.collection('users').doc(userCred.user!.uid).set(newUser.toJson());
        return newUser;
      }
      return UserModel.fromSnapshot(snap);
    }
    return null;
  }

  @override
  Future<UserEntity?> signInWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScope.email,
        AppleIDAuthorizationScope.fullName,
      ],
    );
    
    // Convert to OAuthCredential
    final oauthCred = firebase_auth.OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    var userCred = await _firebaseAuth.signInWithCredential(oauthCred);
    if (userCred.user != null) {
      var snap = await _firestore.collection('users').doc(userCred.user!.uid).get();
      if (!snap.exists) {
        var newUser = UserModel(
          uid: userCred.user!.uid, 
          email: userCred.user!.email ?? "", 
          displayName: "${appleCredential.givenName ?? ""} ${appleCredential.familyName ?? ""}".trim(),
        );
        await _firestore.collection('users').doc(userCred.user!.uid).set(newUser.toJson());
        return newUser;
      }
      return UserModel.fromSnapshot(snap);
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> deleteAccount() async {
    var user = _firebaseAuth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).delete();
      await user.delete();
    }
  }

  @override
  Future<void> updateProfile(UserEntity user) async {
    await _firestore.collection('users').doc(user.uid).update(UserModel.fromEntity(user).toJson());
  }
}
