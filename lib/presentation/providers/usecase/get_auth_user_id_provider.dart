import 'package:flix_tix/domain/usecases/get_auth_user_id/get_auth_user_id.dart';
import 'package:flix_tix/presentation/providers/repositories/auth_repository/auth_repository_provider.dart';
import 'package:flix_tix/presentation/providers/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_auth_user_id_provider.g.dart';

@riverpod
GetAuthUserId getAuthUserId(GetAuthUserIdRef ref) => GetAuthUserId(
      authRepository: ref.watch(authRepositoryProvider),
      userRepository: ref.watch(userRepositoryProvider),
    );
