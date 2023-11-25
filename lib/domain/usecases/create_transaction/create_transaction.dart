import 'package:flix_tix/data/repositories/transaction_repository.dart';
import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/usecases/usecase.dart';
import 'package:flix_tix/domain/usecases/create_transaction/create_transaction_body.dart';

class CreateTransaction
    implements UseCase<Result<void>, CreateTransactionBody> {
  final TransactionRepository transactionRepository;

  CreateTransaction({
    required this.transactionRepository,
  });

  @override
  Future<Result<void>> call(CreateTransactionBody body) async {
    int transactionTime = DateTime.now().millisecondsSinceEpoch;
    var result = await transactionRepository.craeteTransaction(
      transaction: body.transaction.copyWith(
        transactionTime: transactionTime,
        id: body.transaction.id ??
            'flx-$transactionTime-${body.transaction.uid}',
      ),
    );

    return switch (result) {
      Success(value: _) => const Result.success(null),
      Error(message: final message) => Result.error(message),
    };
  }
}
