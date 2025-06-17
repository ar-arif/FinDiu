import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/transaction_model.dart';
import '../models/savings_goal_model.dart';
import '../models/reminder_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User operations
  Future<void> createUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toMap());
  }

  Future<UserModel?> getUser(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    }
    return null;
  }

  Future<void> updateUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).update(user.toMap());
  }

  // Transaction operations
  Future<void> addTransaction(TransactionModel transaction) async {
    await _firestore.collection('transactions').doc(transaction.id).set(transaction.toMap());
  }

  Future<List<TransactionModel>> getUserTransactions(String userId) async {
    final query = await _firestore
        .collection('transactions')
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: true)
        .get();

    return query.docs.map((doc) => TransactionModel.fromMap(doc.data())).toList();
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    await _firestore.collection('transactions').doc(transaction.id).update(transaction.toMap());
  }

  Future<void> deleteTransaction(String transactionId) async {
    await _firestore.collection('transactions').doc(transactionId).delete();
  }

  // Savings Goal operations
  Future<void> addSavingsGoal(SavingsGoalModel goal) async {
    await _firestore.collection('savings_goals').doc(goal.id).set(goal.toMap());
  }

  Future<List<SavingsGoalModel>> getUserSavingsGoals(String userId) async {
    final query = await _firestore
        .collection('savings_goals')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    return query.docs.map((doc) => SavingsGoalModel.fromMap(doc.data())).toList();
  }

  Future<void> updateSavingsGoal(SavingsGoalModel goal) async {
    await _firestore.collection('savings_goals').doc(goal.id).update(goal.toMap());
  }

  Future<void> deleteSavingsGoal(String goalId) async {
    await _firestore.collection('savings_goals').doc(goalId).delete();
  }

  // Reminder operations
  Future<void> addReminder(ReminderModel reminder) async {
    await _firestore.collection('reminders').doc(reminder.id).set(reminder.toMap());
  }

  Future<List<ReminderModel>> getUserReminders(String userId) async {
    final query = await _firestore
        .collection('reminders')
        .where('userId', isEqualTo: userId)
        .orderBy('dueDate', descending: false)
        .get();

    return query.docs.map((doc) => ReminderModel.fromMap(doc.data())).toList();
  }

  Future<void> updateReminder(ReminderModel reminder) async {
    await _firestore.collection('reminders').doc(reminder.id).update(reminder.toMap());
  }

  Future<void> deleteReminder(String reminderId) async {
    await _firestore.collection('reminders').doc(reminderId).delete();
  }
}