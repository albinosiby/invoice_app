import 'package:equatable/equatable.dart';

class InvoiceDueModel extends Equatable {
  final String id;
  final String clientName;
  final String invoiceNumber;
  final String amount;
  final String status;
  final String daysDue;
  final String dueDate;

  const InvoiceDueModel({
    required this.id,
    required this.clientName,
    required this.invoiceNumber,
    required this.amount,
    required this.status,
    required this.daysDue,
    required this.dueDate,
  });

  @override
  List<Object?> get props => [
    id,
    clientName,
    invoiceNumber,
    amount,
    status,
    daysDue,
    dueDate,
  ];
}
