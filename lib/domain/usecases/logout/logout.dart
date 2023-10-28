import 'package:flix_tix/data/repositories/auth_repository.dart';
import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/usecases/usecase.dart';

class Logout implements UseCase<Result<void>, void> {
  final AuthRepository authRepository;

  Logout({
    required this.authRepository,
  });

  @override
  Future<Result<void>> call(void _) => authRepository.logOut();
}
