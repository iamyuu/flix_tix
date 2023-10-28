import 'dart:io';

import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/entities/user.dart';

abstract interface class UserRepository {
  Future<Result<User>> createUser({
    required String uid,
    required String name,
    required String email,
    String? photoUrl,
    int balance = 0,
  });

  Future<Result<User>> getUser({
    required String uid,
  });

  Future<Result<User>> updateUser({
    required User user,
  });

  Future<Result<int>> getUserBalance({
    required String uid,
  });

  Future<Result<User>> topUpBalance({
    required String uid,
    required int balance,
  });

  Future<Result<User>> uploadProfilePicture({
    required User user,
    required File pictureFile,
  });
}
