import 'package:flix_tix/data/repositories/user_repository.dart';
import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/usecases/get_user_balance/get_user_balance_params.dart';
import 'package:flix_tix/domain/usecases/usecase.dart';

class GetUserBalance implements UseCase<Result<int>, GetUserBalanceParams> {
  final UserRepository userRepository;

  GetUserBalance({
    required this.userRepository,
  });

  @override
  Future<Result<int>> call(GetUserBalanceParams params) =>
      userRepository.getUserBalance(uid: params.userId);
}
