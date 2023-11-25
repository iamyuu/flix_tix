import 'package:flix_tix/domain/usecases/logout/logout.dart';
import 'package:flix_tix/presentation/providers/repositories/auth_repository/auth_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logout_provider.g.dart';

@riverpod
Logout logout(LogoutRef ref) => Logout(
      authRepository: ref.watch(authRepositoryProvider),
    );
