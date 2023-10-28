import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flix_tix/data/firebase/user_repository.dart';
import 'package:flix_tix/data/repositories/transaction_repository.dart';
import 'package:flix_tix/domain/entities/result.dart';
import 'package:flix_tix/domain/entities/transaction.dart';

class FirebaseTransactionRepository implements TransactionRepository {
  final firestore.FirebaseFirestore _firestore;

  FirebaseTransactionRepository({
    firestore.FirebaseFirestore? firebaseFirestore,
  }) : _firestore = firebaseFirestore ?? firestore.FirebaseFirestore.instance;

  @override
  Future<Result<Transaction>> craeteTransaction({
    required Transaction transaction,
  }) async {
    firestore.CollectionReference<Map<String, dynamic>> transactionCollection =
        _firestore.collection('transactions');

    try {
      var currentBalance =
          await FirebaseUserRepository().getUserBalance(uid: transaction.uid);

      if (currentBalance.isSuccess) {
        int balance = currentBalance.data! - transaction.total;

        if (balance >= 0) {
          await transactionCollection
              .doc(transaction.id)
              .set(transaction.toJson());

          var result = await transactionCollection.doc(transaction.id).get();

          if (result.exists) {
            await FirebaseUserRepository().topUpBalance(
              uid: transaction.uid,
              balance: balance,
            );

            return Result.success(Transaction.fromJson(result.data()!));
          } else {
            return const Result.error('Failed to create transaction');
          }
        } else {
          return const Result.error('Insufficient balance');
        }
      } else {
        return const Result.error('Failed to create transaction');
      }
    } catch (e) {
      return const Result.error('Failed to create transaction');
    }
  }

  @override
  Future<Result<List<Transaction>>> getUserTransactions({
    required String uid,
  }) async {
    firestore.CollectionReference<Map<String, dynamic>> transactionCollection =
        _firestore.collection('transactions');

    try {
      var result =
          await transactionCollection.where('uid', isEqualTo: uid).get();

      if (result.docs.isNotEmpty) {
        return Result.success(
          result.docs.map((e) => Transaction.fromJson(e.data())).toList(),
        );
      } else {
        return const Result.success([]);
      }
    } catch (e) {
      return const Result.error('Failed to get user transactions');
    }
  }
}
