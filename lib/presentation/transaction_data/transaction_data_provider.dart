import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/entities/transaction.dart';
import 'package:flix_tix/domain/entities/user.dart';
import 'package:flix_tix/domain/usecases/get_transaction/get_transaction.dart';
import 'package:flix_tix/domain/usecases/get_transaction/get_transaction_params.dart';
import 'package:flix_tix/presentation/providers/usecase/get_transaction_provider.dart';
import 'package:flix_tix/presentation/user_data/user_data_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_data_provider.g.dart';

@Riverpod(keepAlive: true)
class TransactionData extends _$TransactionData {
  @override
  Future<List<Transaction>> build() async {
    User? user = ref.read(userDataProvider).valueOrNull;

    if (user != null) {
      state = const AsyncLoading();

      GetTransaction getTransactions = ref.read(getTransactionProvider);

      var result = await getTransactions(GetTransactionParams(uid: user.uid));

      if (result case Success(value: final transactions)) {
        return transactions;
      }
    }

    return const [];
  }

  Future<void> refreshTransactionData() async {
    User? user = ref.read(userDataProvider).valueOrNull;

    if (user != null) {
      state = const AsyncLoading();

      GetTransaction getTransactions = ref.read(getTransactionProvider);

      var result = await getTransactions(GetTransactionParams(uid: user.uid));

      switch (result) {
        case Success(value: final transactions):
          state = AsyncData(transactions);
        case Error(:final message):
          state = AsyncError(FlutterError(message), StackTrace.current);
          state = AsyncData(state.valueOrNull ?? const []);
      }
    }
  }
}
