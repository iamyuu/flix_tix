import 'package:flix_tix/domain/entities/transaction.dart';

class CreateTransactionBody {
  final Transaction transaction;

  CreateTransactionBody({
    required this.transaction,
  });
}
