class AddInvoices {
  final String id;
  final String clientId;
  final DateTime date;
  final List<InvoiceItem> items;
  final double discount;
  final double taxRate;
  final String notes;
  final bool markAsPaid;
  final bool acceptCardPayments;
  final bool requestSignature;

  AddInvoices({
    required this.id,
    required this.clientId,
    required this.date,
    required this.items,
    this.discount = 0,
    this.taxRate = 18.0,
    this.notes = '',
    this.markAsPaid = false,
    this.acceptCardPayments = false,
    this.requestSignature = false,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);

  double get taxAmount => (subtotal - discount) * (taxRate / 100);

  double get total => (subtotal - discount) + taxAmount;

  double get balanceDue => markAsPaid ? 0 : total;

  AddInvoices copyWith({
    String? id,
    String? clientId,
    DateTime? date,
    List<InvoiceItem>? items,
    double? discount,
    double? taxRate,
    String? notes,
    bool? markAsPaid,
    bool? acceptCardPayments,
    bool? requestSignature,
  }) {
    return AddInvoices(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      date: date ?? this.date,
      items: items ?? this.items,
      discount: discount ?? this.discount,
      taxRate: taxRate ?? this.taxRate,
      notes: notes ?? this.notes,
      markAsPaid: markAsPaid ?? this.markAsPaid,
      acceptCardPayments: acceptCardPayments ?? this.acceptCardPayments,
      requestSignature: requestSignature ?? this.requestSignature,
    );
  }
}

class InvoiceItem {
  final String id;
  final String name;
  final String description;
  final int quantity;
  final double unitPrice;

  InvoiceItem({
    required this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.unitPrice,
  });

  double get totalPrice => quantity * unitPrice;

  InvoiceItem copyWith({
    String? id,
    String? name,
    String? description,
    int? quantity,
    double? unitPrice,
  }) {
    return InvoiceItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }
}
