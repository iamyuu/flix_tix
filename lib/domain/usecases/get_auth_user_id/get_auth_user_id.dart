import 'package:flix_tix/data/repositories/auth_repository.dart';
import 'package:flix_tix/data/repositories/user_repository.dart';
import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/entities/user.dart';
import 'package:flix_tix/domain/usecases/usecase.dart';

class GetAuthUserId implements UseCase<Result<User>, void> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  GetAuthUserId({
    required this.authRepository,
    required this.userRepository,
  });

  @override
  Future<Result<User>> call(void _) async {
    String? uid = authRepository.getAuthUserId();

    if (uid != null) {
      var user = await userRepository.getUser(uid: uid);

      return switch (user) {
        Success(value: final user) => Result.success(user),
        Error(:final message) => Result.error(message),
      };
    } else {
      return const Result.error('No user logged in');
    }
  }
}
