import 'package:flutter/material.dart';
import '../models/reminder_model.dart';
import '../services/firestore_service.dart';

class ReminderProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  
  List<ReminderModel> _reminders = [];
  bool _isLoading = false;
  String? _error;

  List<ReminderModel> get reminders => _reminders;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<ReminderModel> get pendingReminders {
    return _reminders.where((r) => !r.isCompleted).toList();
  }

  List<ReminderModel> get completedReminders {
    return _reminders.where((r) => r.isCompleted).toList();
  }

  List<ReminderModel> get overdueReminders {
    return _reminders.where((r) => r.isOverdue).toList();
  }

  Future<void> loadReminders(String userId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _reminders = await _firestoreService.getUserReminders(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addReminder(ReminderModel reminder) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestoreService.addReminder(reminder);
      _reminders.add(reminder);
      
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateReminder(ReminderModel reminder) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestoreService.updateReminder(reminder);
      
      final index = _reminders.indexWhere((r) => r.id == reminder.id);
      if (index != -1) {
        _reminders[index] = reminder;
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

  Future<bool> markAsCompleted(String reminderId) async {
    try {
      final reminderIndex = _reminders.indexWhere((r) => r.id == reminderId);
      if (reminderIndex == -1) return false;

      final updatedReminder = _reminders[reminderIndex].copyWith(
        isCompleted: true,
      );

      return await updateReminder(updatedReminder);
    } catch (e) {
      _error = e.toString();
      return false;
    }
  }

  Future<bool> deleteReminder(String reminderId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestoreService.deleteReminder(reminderId);
      _reminders.removeWhere((r) => r.id == reminderId);
      
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