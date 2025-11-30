import 'package:uuid/uuid.dart';

class Transaction {
  final String id;
  final double amount;
  final String category;
  final String? description;
  final DateTime date;
  final TransactionType type;
  final DateTime createdAt;

  Transaction({
    String? id,
    required this.amount,
    required this.category,
    this.description,
    required this.date,
    required this.type,
    DateTime? createdAt,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'description': description,
      'date': date.toIso8601String(),
      'type': type.toString().split('.').last,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      category: json['category'] as String,
      description: json['description'] as String?,
      date: DateTime.parse(json['date'] as String),
      type: TransactionType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Transaction copyWith({
    String? id,
    double? amount,
    String? category,
    String? description,
    DateTime? date,
    TransactionType? type,
    DateTime? createdAt,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      description: description ?? this.description,
      date: date ?? this.date,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

enum TransactionType { expense, income }
