class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final String type;
  final String category;
  final String note;
  final DateTime date;

  const TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.note,
    required this.date,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] ?? 'expense',
      category: json['category'] ?? 'Lainnya',
      note: json['note'] ?? '',
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'type': type,
      'category': category,
      'note': note,
      'date': date.toIso8601String(),
    };
  }

  TransactionModel copyWith({
    String? id,
    String? title,
    double? amount,
    String? type,
    String? category,
    String? note,
    DateTime? date,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      category: category ?? this.category,
      note: note ?? this.note,
      date: date ?? this.date,
    );
  }
}
