import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flix_tix/data/repositories/user_repository.dart';
import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/entities/user.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseUserRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<Result<User>> createUser(
      {required String uid,
      required String name,
      required String email,
      String? photoUrl,
      int balance = 0}) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> getUser({required String uid}) async {
    DocumentReference<Map<String, dynamic>> userDoc =
        _firebaseFirestore.collection('users').doc(uid);
    DocumentSnapshot<Map<String, dynamic>> userSnapshot = await userDoc.get();

    if (userSnapshot.exists) {
      return Result.success(User.fromJson(userSnapshot.data()!));
    } else {
      return const Result.error('User not found');
    }
  }

  @override
  Future<Result<int>> getUserBalance({required String uid}) {
    // TODO: implement getUserBalance
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> topUpBalance(
      {required String uid, required int balance}) {
    // TODO: implement topUpBalance
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> updateUser(
      {required String uid,
      required String name,
      required String email,
      String? photoUrl,
      int? balance}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> uploadProfilePicture(
      {required String uid, required File pictureFile}) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
