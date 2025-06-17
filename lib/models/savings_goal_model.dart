class SavingsGoalModel {
  final String id;
  final String userId;
  final String title;
  final double targetAmount;
  final double currentAmount;
  final String category;
  final DateTime deadline;
  final DateTime createdAt;
  final DateTime updatedAt;

  SavingsGoalModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.targetAmount,
    required this.currentAmount,
    required this.category,
    required this.deadline,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SavingsGoalModel.fromMap(Map<String, dynamic> map) {
    return SavingsGoalModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      targetAmount: (map['targetAmount'] ?? 0).toDouble(),
      currentAmount: (map['currentAmount'] ?? 0).toDouble(),
      category: map['category'] ?? '',
      deadline: DateTime.fromMillisecondsSinceEpoch(map['deadline'] ?? 0),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] ?? 0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'targetAmount': targetAmount,
      'currentAmount': currentAmount,
      'category': category,
      'deadline': deadline.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  double get progress => targetAmount > 0 ? (currentAmount / targetAmount) : 0;

  int get daysLeft {
    final now = DateTime.now();
    return deadline.difference(now).inDays;
  }

  SavingsGoalModel copyWith({
    String? title,
    double? targetAmount,
    double? currentAmount,
    String? category,
    DateTime? deadline,
  }) {
    return SavingsGoalModel(
      id: id,
      userId: userId,
      title: title ?? this.title,
      targetAmount: targetAmount ?? this.targetAmount,
      currentAmount: currentAmount ?? this.currentAmount,
      category: category ?? this.category,
      deadline: deadline ?? this.deadline,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}