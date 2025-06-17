enum ReminderType { bill, payment, deadline }

class ReminderModel {
  final String id;
  final String userId;
  final String title;
  final double amount;
  final DateTime dueDate;
  final ReminderType type;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReminderModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.amount,
    required this.dueDate,
    required this.type,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReminderModel.fromMap(Map<String, dynamic> map) {
    return ReminderModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate'] ?? 0),
      type: ReminderType.values.firstWhere(
        (e) => e.toString() == 'ReminderType.${map['type']}',
        orElse: () => ReminderType.deadline,
      ),
      isCompleted: map['isCompleted'] ?? false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] ?? 0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'amount': amount,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'type': type.toString().split('.').last,
      'isCompleted': isCompleted,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  int get daysLeft {
    final now = DateTime.now();
    return dueDate.difference(now).inDays;
  }

  bool get isOverdue {
    return DateTime.now().isAfter(dueDate) && !isCompleted;
  }

  ReminderModel copyWith({
    String? title,
    double? amount,
    DateTime? dueDate,
    ReminderType? type,
    bool? isCompleted,
  }) {
    return ReminderModel(
      id: id,
      userId: userId,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      dueDate: dueDate ?? this.dueDate,
      type: type ?? this.type,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}