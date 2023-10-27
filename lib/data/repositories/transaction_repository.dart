import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/entities/transaction.dart';

abstract interface class TransactionRepository {
  Future<Result<Transaction>> craeteTransaction({
    required Transaction transaction,
  });

  Future<Result<List<Transaction>>> getUserTransactions({
    required String uid,
  });
}
