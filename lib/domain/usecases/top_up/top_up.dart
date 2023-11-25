import 'package:flix_tix/data/repositories/transaction_repository.dart';
import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/entities/transaction.dart';
import 'package:flix_tix/domain/usecases/create_transaction/create_transaction.dart';
import 'package:flix_tix/domain/usecases/create_transaction/create_transaction_body.dart';
import 'package:flix_tix/domain/usecases/top_up/top_up_body.dart';
import 'package:flix_tix/domain/usecases/usecase.dart';

class TopUp implements UseCase<void, TopUpBody> {
  final TransactionRepository transactionRepository;

  TopUp({
    required this.transactionRepository,
  });

  @override
  Future<Result<void>> call(TopUpBody params) async {
    CreateTransaction createTransaction = CreateTransaction(
      transactionRepository: transactionRepository,
    );
    int transactionTime = DateTime.now().millisecondsSinceEpoch;

    var result = await createTransaction(
      CreateTransactionBody(
        transaction: Transaction(
          id: 'flx-tp-$transactionTime-${params.userId}',
          uid: params.userId,
          title: 'Top Up',
          total: -params.amount,
          adminFee: 0,
          transactionTime: transactionTime,
        ),
      ),
    );

    return switch (result) {
      Success(value: _) => const Result.success(null),
      Error(message: _) => const Result.error('Failed to top up'),
    };
  }
}
