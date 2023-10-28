import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/entities/user.dart';
import 'package:flix_tix/domain/usecases/usecase.dart';
import 'package:flix_tix/data/repositories/auth_repository.dart';
import 'package:flix_tix/data/repositories/user_repository.dart';

part 'login_body.dart';

class Login implements UseCase<Result<User>, LoginBody> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  Login({
    required this.authRepository,
    required this.userRepository,
  });

  @override
  Future<Result<User>> call(LoginBody body) async {
    final authResult = await authRepository.logInWithCredentials(
      email: body.email,
      password: body.password,
    );

    if (authResult is Success) {
      final userResult = await userRepository.getUser(
        uid: authResult.data!,
      );

      return switch (userResult) {
        Success(value: final user) => Result.success(user),
        Error(:final message) => Result.error(message),
      };
    } else {
      return Result.error(authResult.error!);
    }
  }
}
