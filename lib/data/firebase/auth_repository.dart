import 'package:flix_tix/data/repositories/auth_repository.dart';
import 'package:flix_tix/domain/entities/result.dart';

// avoid clashes between the Firebase auth package and our own auth package
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class FirebaseAuthRepository implements AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  // if the firebaseAuth parameter is not provided, use firebase_auth instance
  FirebaseAuthRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  @override
  String? getAuthUserId() => _firebaseAuth.currentUser?.uid;

  @override
  Future<Result<String>> logInWithCredentials({
    required String email,
    required String password,
  }) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Result.success(userCredential.user!.uid);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Result.error(e.message!);
    }
  }

  @override
  Future<Result<void>> logOut() async {
    await _firebaseAuth.signOut();

    if (_firebaseAuth.currentUser == null) {
      return const Result.success(null);
    } else {
      return const Result.error('Unable to log out');
    }
  }

  @override
  Future<Result<String>> registerWithCredentials({
    required String email,
    required String password,
  }) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Result.success(userCredential.user!.uid);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Result.error('Error: ${e.message}');
    }
  }
}
