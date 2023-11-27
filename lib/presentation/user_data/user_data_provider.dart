import 'dart:io';

import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/entities/user.dart';
import 'package:flix_tix/domain/usecases/get_auth_user_id/get_auth_user_id.dart';
import 'package:flix_tix/domain/usecases/login/login.dart';
import 'package:flix_tix/domain/usecases/register/register.dart';
import 'package:flix_tix/domain/usecases/top_up/top_up.dart';
import 'package:flix_tix/domain/usecases/top_up/top_up_body.dart';
import 'package:flix_tix/domain/usecases/update_profile_picture/upload_profile_picture.dart';
import 'package:flix_tix/domain/usecases/update_profile_picture/upload_profile_picture_body.dart';
import 'package:flix_tix/presentation/providers/movie/now_playing_provider.dart';
import 'package:flix_tix/presentation/providers/movie/upcoming_provider.dart';
import 'package:flix_tix/presentation/providers/register_provider.dart';
import 'package:flix_tix/presentation/providers/usecase/get_auth_user_id_provider.dart';
import 'package:flix_tix/presentation/providers/usecase/login_provider.dart';
import 'package:flix_tix/presentation/providers/usecase/logout_provider.dart';
import 'package:flix_tix/presentation/providers/usecase/top_up_provider.dart';
import 'package:flix_tix/presentation/providers/usecase/upload_profile_picture_provider.dart';
import 'package:flix_tix/presentation/transaction_data/transaction_data_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  @override
  Future<User?> build() async {
    GetAuthUserId getLoggedInUser = ref.read(getAuthUserIdProvider);
    var userResult = await getLoggedInUser(null);

    switch (userResult) {
      case Success(value: final user):
        _getMovies();
        return user;
      case Error(message: _):
        return null;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    Login login = ref.read(loginProvider);

    var result = await login(LoginBody(email: email, password: password));

    switch (result) {
      case Success(value: final user):
        _getMovies();
        state = AsyncData(user);
      case Error(:final message):
        state = AsyncError(
          FlutterError(message),
          StackTrace.current,
        );
        state = const AsyncData(null);
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    String? imageUrl,
  }) async {
    state = const AsyncLoading();

    Register register = ref.read(registerProvider);

    var result = await register(RegisterBody(
        name: name, email: email, password: password, photoUrl: imageUrl));

    switch (result) {
      case Success(value: final user):
        _getMovies();
        state = AsyncData(user);
      case Error(:final message):
        state = AsyncError(
          FlutterError(message),
          StackTrace.current,
        );
        state = const AsyncData(null);
    }
  }

  Future<void> refreshUserData() async {
    GetAuthUserId getLoggedInUser = ref.read(getAuthUserIdProvider);

    var result = await getLoggedInUser(null);

    if (result case Success(value: final user)) {
      state = AsyncData(user);
    }
  }

  Future<void> logout() async {
    var logout = ref.read(logoutProvider);
    var result = await logout(null);

    switch (result) {
      case Success(value: _):
        state = const AsyncData(null);
      case Error(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = AsyncData(state.valueOrNull);
    }
  }

  Future<void> topUp(int amount) async {
    TopUp topUp = ref.read(topUpProvider);

    String? userId = state.valueOrNull?.uid;

    if (userId != null) {
      var result = await topUp(TopUpBody(amount: amount, userId: userId));

      if (result.isSuccess) {
        refreshUserData();
        ref.read(transactionDataProvider.notifier).refreshTransactionData();
      }
    }
  }

  Future<void> uploadProfilePicture({
    required User user,
    required File pictureFile,
  }) async {
    UploadProfilePicture uploadProfilePicture =
        ref.read(uploadProfilePictureProvider);

    var result = await uploadProfilePicture(UploadProfilePictureBody(
      pictureFile: pictureFile,
      user: user,
    ));

    if (result case Success(value: final user)) {
      state = AsyncData(user);
    }
  }

  void _getMovies() {
    ref.read(nowPlayingProvider.notifier).getMovies();
    ref.read(upcomingProvider.notifier).getMovies();
  }
}
