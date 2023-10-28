import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flix_tix/data/repositories/user_repository.dart';
import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/entities/user.dart';
import 'package:path/path.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseUserRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<Result<User>> createUser({
    required String uid,
    required String name,
    required String email,
    String? photoUrl,
    int balance = 0,
  }) async {
    try {
      CollectionReference<Map<String, dynamic>> userCollection =
          _firebaseFirestore.collection('users');

      await userCollection.doc(uid).set({
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
        'balance': balance,
      });

      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await userCollection.doc(uid).get();

      if (userSnapshot.exists) {
        return Result.success(User.fromJson(userSnapshot.data()!));
      } else {
        return const Result.error('Failed to create user');
      }
    } on FirebaseException catch (e) {
      return Result.error(e.message ?? 'Failed to create user');
    } catch (e) {
      return const Result.error('Failed to create user');
    }
  }

  @override
  Future<Result<User>> getUser({
    required String uid,
  }) async {
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
  Future<Result<int>> getUserBalance({
    required String uid,
  }) async {
    DocumentReference<Map<String, dynamic>> userDoc =
        _firebaseFirestore.collection('users').doc(uid);
    DocumentSnapshot<Map<String, dynamic>> userSnapshot = await userDoc.get();

    if (userSnapshot.exists) {
      return Result.success(userSnapshot.data()!['balance']);
    } else {
      return const Result.error('User not found');
    }
  }

  @override
  Future<Result<User>> topUpBalance({
    required String uid,
    required int balance,
  }) async {
    DocumentReference<Map<String, dynamic>> userDoc =
        _firebaseFirestore.collection('users').doc(uid);
    DocumentSnapshot<Map<String, dynamic>> userSnapshot = await userDoc.get();

    if (userSnapshot.exists) {
      int currentBalance = userSnapshot.data()!['balance'];
      int newBalance = currentBalance + balance;

      await userDoc.update({
        'balance': newBalance,
      });

      DocumentSnapshot<Map<String, dynamic>> updatedUserSnapshot =
          await userDoc.get();

      if (updatedUserSnapshot.exists) {
        User updatedUser = User.fromJson(updatedUserSnapshot.data()!);

        if (updatedUser.balance == newBalance) {
          return Result.success(updatedUser);
        } else {
          return const Result.error('Failed to top up balance');
        }
      } else {
        return const Result.error('Failed to top up balance');
      }
    } else {
      return const Result.error('User not found');
    }
  }

  @override
  Future<Result<User>> updateUser({
    required User user,
  }) async {
    try {
      DocumentReference<Map<String, dynamic>> userDoc =
          _firebaseFirestore.collection('users').doc(user.uid);

      await userDoc.update({
        'name': user.name,
        'email': user.email,
        'photoUrl': user.photoUrl,
        'balance': user.balance,
      });

      DocumentSnapshot<Map<String, dynamic>> userSnapshot = await userDoc.get();

      if (userSnapshot.exists) {
        User updatedUser = User.fromJson(userSnapshot.data()!);

        if (updatedUser == user) {
          return Result.success(updatedUser);
        } else {
          return const Result.error('Failed to update user');
        }
      } else {
        return const Result.error('Failed to update user');
      }
    } on FirebaseException catch (e) {
      return Result.error(e.message ?? 'Failed to update user');
    } catch (e) {
      return const Result.error('Failed to update user');
    }
  }

  @override
  Future<Result<User>> uploadProfilePicture({
    required User user,
    required File pictureFile,
  }) async {
    String filename = basename(pictureFile.path);
    Reference ref = FirebaseStorage.instance.ref().child(filename);

    try {
      UploadTask uploadTask = ref.putFile(pictureFile);
      TaskSnapshot taskSnapshot = await uploadTask;

      if (taskSnapshot.state == TaskState.success) {
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        var updatedUser = await updateUser(
          user: user.copyWith(
            photoUrl: downloadUrl,
          ),
        );

        if (updatedUser.isSuccess) {
          return Result.success(updatedUser.data!);
        } else {
          return const Result.error('Failed to upload profile picture');
        }
      } else {
        return const Result.error('Failed to upload profile picture');
      }
    } on FirebaseException catch (e) {
      return Result.error(e.message ?? 'Failed to upload profile picture');
    } catch (e) {
      return const Result.error('Failed to upload profile picture');
    }
  }
}
