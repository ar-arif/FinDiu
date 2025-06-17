enum TransactionType { income, expense }

class TransactionModel {
  final String id;
  final String userId;
  final double amount;
  final String description;
  final String category;
  final TransactionType type;
  final DateTime date;
  final DateTime createdAt;

  TransactionModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.description,
    required this.category,
    required this.type,
    required this.date,
    required this.createdAt,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      type: TransactionType.values.firstWhere(
        (e) => e.toString() == 'TransactionType.${map['type']}',
        orElse: () => TransactionType.expense,
      ),
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] ?? 0),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'amount': amount,
      'description': description,
      'category': category,
      'type': type.toString().split('.').last,
      'date': date.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }
}