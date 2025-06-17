import 'package:flutter/material.dart';
import '../main.dart'; // Import AppScreen enum
import 'package:intl/intl.dart';

// Mock data for now
class Reminder {
  final String id;
  final String title;
  final String type;
  final DateTime dueDate;
  final double amount;
  bool isCompleted;

  Reminder({
    required this.id,
    required this.title,
    required this.type,
    required this.dueDate,
    required this.amount,
    this.isCompleted = false,
  });
}

List<Reminder> mockReminders = [
  Reminder(
    id: '1',
    title: 'University Fee Payment',
    type: 'payment',
    dueDate: DateTime.now().add(const Duration(days: 5)),
    amount: 15000,
  ),
  Reminder(
    id: '2',
    title: 'Electricity Bill',
    type: 'bill',
    dueDate: DateTime.now().subtract(const Duration(days: 2)),
    amount: 800,
  ),
  Reminder(
    id: '3',
    title: 'Project Deadline',
    type: 'deadline',
    dueDate: DateTime.now().add(const Duration(days: 10)),
    amount: 0,
  ),
  Reminder(
    id: '4',
    title: 'Internet Bill',
    type: 'bill',
    dueDate: DateTime.now().subtract(const Duration(days: 7)),
    amount: 1200,
    isCompleted: true,
  ),
];

class RemindersScreen extends StatefulWidget {
  final Function(AppScreen) onNavigate;

  const RemindersScreen({super.key, required this.onNavigate});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'bill':
        return Icons.lightbulb_outline;
      case 'payment':
        return Icons.school_outlined;
      case 'deadline':
        return Icons.assignment_outlined;
      default:
        return Icons.access_time;
    }
  }

  String _formatDate(DateTime date) {
    final today = DateTime.now();
    final difference = date.difference(today);

    if (difference.inDays == 0 && date.day == today.day) {
      return 'Today';
    } else if (difference.inDays == 1 && date.day == today.day + 1) {
      return 'Tomorrow';
    } else if (difference.inDays < 0) {
      return '${difference.inDays.abs()} days overdue';
    } else {
      return 'In ${difference.inDays} days';
    }
  }

  String _formatCurrency(double amount) {
    final format = NumberFormat.currency(
      locale: 'en_BD',
      symbol: '৳',
      decimalDigits: 0,
    );
    return format.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final pendingReminders = mockReminders.where((r) => !r.isCompleted).length;
    final completedReminders = mockReminders.where((r) => r.isCompleted).length;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Header
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF805AD5), // from-accent-500
                    Color(0xFFED8936), // to-secondary-500
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () => widget.onNavigate(AppScreen.dashboard),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Reminders',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Stats
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFFFFFFFF,
                      ).withAlpha((0.1 * 255).round()),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                pendingReminders.toString(),
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Pending',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                completedReminders.toString(),
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Completed',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24), // px-6
              child: Transform.translate(
                offset: const Offset(0, -24), // -mt-6
                child: Column(
                  children: [
                    // Add Reminder Button
                    InkWell(
                      onTap: () {
                        // Handle Add Reminder
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withAlpha((0.1 * 255).round()),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF805AD5), // from-accent-500
                                    Color(0xFFED8936), // to-secondary-500
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const <Widget>[
                                  Text(
                                    'Add Reminder',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1A202C),
                                    ),
                                  ),
                                  Text(
                                    'Never miss a payment again',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF4A5568),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Reminders List
                    Column(
                      children:
                          mockReminders.map((reminder) {
                            final bool isOverdue =
                                reminder.dueDate.isBefore(DateTime.now()) &&
                                !reminder.isCompleted;
                            final String daysDiff = _formatDate(
                              reminder.dueDate,
                            );

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withAlpha(
                                        (0.1 * 255).round(),
                                      ),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  border: Border(
                                    left: BorderSide(
                                      color:
                                          reminder.isCompleted
                                              ? const Color(
                                                0xFFED8936,
                                              ) // border-secondary-500
                                              : isOverdue
                                              ? const Color(
                                                0xFFEF4444,
                                              ) // border-red-500
                                              : const Color(
                                                0xFFECC94B,
                                              ), // border-yellow-500
                                      width: 4,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      _getTypeIcon(reminder.type),
                                      size: 24,
                                      color: const Color(
                                        0xFF1A202C,
                                      ), // text-gray-900
                                    ), // text-2xl is replaced by icon size and color
                                    const SizedBox(width: 16), // space-x-4
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  reminder.title,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        reminder.isCompleted
                                                            ? const Color(
                                                              0xFF718096,
                                                            ) // text-gray-500 line-through
                                                            : const Color(
                                                              0xFF1A202C,
                                                            ),
                                                    decoration:
                                                        reminder.isCompleted
                                                            ? TextDecoration
                                                                .lineThrough
                                                            : TextDecoration
                                                                .none,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    reminder.isCompleted =
                                                        !reminder.isCompleted;
                                                  });
                                                },
                                                icon: Icon(
                                                  reminder.isCompleted
                                                      ? Icons.check_circle
                                                      : Icons.circle_outlined,
                                                  color:
                                                      reminder.isCompleted
                                                          ? const Color(
                                                            0xFFED8936,
                                                          ) // text-secondary-500
                                                          : const Color(
                                                            0xFFA0AEC0,
                                                          ), // text-gray-400
                                                  size: 24, // w-6 h-6
                                                ),
                                                splashRadius: 20,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8), // mb-2

                                          Row(
                                            children: <Widget>[
                                              const Icon(
                                                Icons.access_time,
                                                color: Color(0xFF4A5568),
                                                size: 16,
                                              ), // w-4 h-4 text-gray-600
                                              const SizedBox(
                                                width: 4,
                                              ), // space-x-1
                                              Text(
                                                daysDiff,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      isOverdue &&
                                                              !reminder
                                                                  .isCompleted
                                                          ? const Color(
                                                            0xFFE53E3E,
                                                          ) // text-red-600 font-medium
                                                          : const Color(
                                                            0xFF4A5568,
                                                          ),
                                                  fontWeight:
                                                      isOverdue &&
                                                              !reminder
                                                                  .isCompleted
                                                          ? FontWeight.w500
                                                          : FontWeight.normal,
                                                ),
                                              ),
                                              if (reminder.amount > 0)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        left: 16.0,
                                                      ), // space-x-4
                                                  child: Row(
                                                    children: <Widget>[
                                                      const Icon(
                                                        Icons.money,
                                                        color: Color(
                                                          0xFF4A5568,
                                                        ),
                                                        size: 16,
                                                      ), // w-4 h-4
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        _formatCurrency(
                                                          reminder.amount,
                                                        ),
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Color(
                                                            0xFF4A5568,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(height: 12), // mb-3

                                          if (!reminder.isCompleted)
                                            ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  reminder.isCompleted = true;
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(
                                                  0xFFF0F4F8,
                                                ), // bg-primary-50
                                                foregroundColor: const Color(
                                                  0xFF553C9A,
                                                ), // text-primary-700
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        8,
                                                      ), // rounded-xl
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8,
                                                    ), // px-4 py-2
                                                elevation: 0,
                                              ),
                                              child: const Text(
                                                'Mark as Done',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
