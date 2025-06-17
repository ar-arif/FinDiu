import 'package:flutter/material.dart';
import '../models/savings_goal_model.dart';
import '../services/firestore_service.dart';

class SavingsProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  
  List<SavingsGoalModel> _savingsGoals = [];
  bool _isLoading = false;
  String? _error;

  List<SavingsGoalModel> get savingsGoals => _savingsGoals;
  bool get isLoading => _isLoading;
  String? get error => _error;

  double get totalSaved {
    return _savingsGoals.fold(0.0, (sum, goal) => sum + goal.currentAmount);
  }

  double get totalTarget {
    return _savingsGoals.fold(0.0, (sum, goal) => sum + goal.targetAmount);
  }

  double get overallProgress {
    if (totalTarget == 0) return 0;
    return totalSaved / totalTarget;
  }

  Future<void> loadSavingsGoals(String userId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _savingsGoals = await _firestoreService.getUserSavingsGoals(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addSavingsGoal(SavingsGoalModel goal) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestoreService.addSavingsGoal(goal);
      _savingsGoals.add(goal);
      
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateSavingsGoal(SavingsGoalModel goal) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestoreService.updateSavingsGoal(goal);
      
      final index = _savingsGoals.indexWhere((g) => g.id == goal.id);
      if (index != -1) {
        _savingsGoals[index] = goal;
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

  Future<bool> addMoneyToGoal(String goalId, double amount) async {
    try {
      final goalIndex = _savingsGoals.indexWhere((g) => g.id == goalId);
      if (goalIndex == -1) return false;

      final updatedGoal = _savingsGoals[goalIndex].copyWith(
        currentAmount: _savingsGoals[goalIndex].currentAmount + amount,
      );

      return await updateSavingsGoal(updatedGoal);
    } catch (e) {
      _error = e.toString();
      return false;
    }
  }

  Future<bool> deleteSavingsGoal(String goalId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestoreService.deleteSavingsGoal(goalId);
      _savingsGoals.removeWhere((g) => g.id == goalId);
      
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