import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../services/firestore_service.dart';

class TransactionProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  
  List<TransactionModel> _transactions = [];
  bool _isLoading = false;
  String? _error;

  List<TransactionModel> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get error => _error;

  double get totalBalance {
    double balance = 0;
    for (var transaction in _transactions) {
      if (transaction.type == TransactionType.income) {
        balance += transaction.amount;
      } else {
        balance -= transaction.amount;
      }
    }
    return balance;
  }

  double get monthlyIncome {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    
    return _transactions
        .where((t) => t.type == TransactionType.income && 
                     t.date.isAfter(startOfMonth))
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get monthlyExpenses {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    
    return _transactions
        .where((t) => t.type == TransactionType.expense && 
                     t.date.isAfter(startOfMonth))
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  List<TransactionModel> get recentTransactions {
    final sorted = List<TransactionModel>.from(_transactions);
    sorted.sort((a, b) => b.date.compareTo(a.date));
    return sorted.take(10).toList();
  }

  Map<String, double> get categoryExpenses {
    final Map<String, double> categories = {};
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    
    for (var transaction in _transactions) {
      if (transaction.type == TransactionType.expense && 
          transaction.date.isAfter(startOfMonth)) {
        categories[transaction.category] = 
            (categories[transaction.category] ?? 0) + transaction.amount;
      }
    }
    
    return categories;
  }

  Future<void> loadTransactions(String userId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _transactions = await _firestoreService.getUserTransactions(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addTransaction(TransactionModel transaction) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestoreService.addTransaction(transaction);
      _transactions.add(transaction);
      
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateTransaction(TransactionModel transaction) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestoreService.updateTransaction(transaction);
      
      final index = _transactions.indexWhere((t) => t.id == transaction.id);
      if (index != -1) {
        _transactions[index] = transaction;
      }
      
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteTransaction(String transactionId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestoreService.deleteTransaction(transactionId);
      _transactions.removeWhere((t) => t.id == transactionId);
      
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}