import 'package:flix_tix/data/repositories/auth_repository.dart';
import 'package:flix_tix/data/repositories/user_repository.dart';
import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/entities/user.dart';
import 'package:flix_tix/domain/usecases/usecase.dart';

part 'register_body.dart';

class Register implements UseCase<Result<User>, RegisterBody> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  Register({
    required this.authRepository,
    required this.userRepository,
  });

  @override
  Future<Result<User>> call(RegisterBody body) async {
    var createdUid = await authRepository.registerWithCredentials(
      email: body.email,
      password: body.password,
    );

    if (createdUid.isSuccess) {
      var craetedUser = await userRepository.createUser(
        uid: createdUid.data!,
        name: body.name,
        email: body.email,
        photoUrl: body.photoUrl,
      );

      return switch (craetedUser) {
        Success(value: final user) => Result.success(user),
        Error(:final message) => Result.error(message),
      };
    } else {
      return Result.error(createdUid.error!);
    }
  }
}
