import 'package:flix_tix/domain/entities/result.dart';

abstract interface class AuthRepository {
  Future<Result<String>> registerWithCredentials({
    required String email,
    required String password,
  });

  Future<Result<String>> logInWithCredentials({
    required String email,
    required String password,
  });

  Future<void> logOut();

  String? getUserId();
}
