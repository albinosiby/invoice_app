class Invoice {
  final String id;
  final String clientName;
  final String invoiceNumber;
  final double amount;
  final String status;
  final DateTime dueDate;
  final DateTime createdAt;

  Invoice({
    required this.id,
    required this.clientName,
    required this.invoiceNumber,
    required this.amount,
    required this.status,
    required this.dueDate,
    required this.createdAt,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      clientName: json['clientName'],
      invoiceNumber: json['invoiceNumber'],
      amount: (json['amount'] as num).toDouble(),
      status: json['status'],
      dueDate: DateTime.parse(json['dueDate']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientName': clientName,
      'invoiceNumber': invoiceNumber,
      'amount': amount,
      'status': status,
      'dueDate': dueDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Invoice copyWith({
    String? id,
    String? clientName,
    String? invoiceNumber,
    double? amount,
    String? status,
    DateTime? dueDate,
    DateTime? createdAt,
  }) {
    return Invoice(
      id: id ?? this.id,
      clientName: clientName ?? this.clientName,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

enum InvoiceStatus {
  pending('Pending'),
  paid('Paid'),
  overdue('Overdue');

  final String value;
  const InvoiceStatus(this.value);
}
