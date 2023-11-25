import 'package:flix_tix/data/repositories/transaction_repository.dart';
import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/entities/transaction.dart';
import 'package:flix_tix/domain/usecases/get_transaction/get_transaction_params.dart';
import 'package:flix_tix/domain/usecases/usecase.dart';

class GetTransaction
    implements UseCase<Result<List<Transaction>>, GetTransactionParams> {
  final TransactionRepository transactionRepository;

  GetTransaction({
    required this.transactionRepository,
  });

  @override
  Future<Result<List<Transaction>>> call(GetTransactionParams params) async {
    var result = await transactionRepository.getUserTransactions(
      uid: params.uid,
    );

    return switch (result) {
      Success(value: final transactions) => Result.success(transactions),
      Error(message: final message) => Result.error(message),
    };
  }
}
