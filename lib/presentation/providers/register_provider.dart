import 'package:flix_tix/domain/usecases/register/register.dart';
import 'package:flix_tix/presentation/providers/repositories/auth_repository/auth_repository_provider.dart';
import 'package:flix_tix/presentation/providers/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_provider.g.dart';

@riverpod
Register register(RegisterRef ref) => Register(
      authRepository: ref.watch(authRepositoryProvider),
      userRepository: ref.watch(userRepositoryProvider),
    );
