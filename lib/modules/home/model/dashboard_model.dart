import 'package:equatable/equatable.dart';

class DashboardCardModel extends Equatable {
  final String? logoImageUrl;
  final double totalInvoice;
  final int numberOfInvoice;
  final double paymentReceived;
  final int paymentrecivedPercent;
  final double outstandingPayment;
  final int numberOfOverDue;
  final double expense;
  final double netProfit;

  const DashboardCardModel({
    this.logoImageUrl,
    required this.totalInvoice,
    required this.numberOfInvoice,
    required this.paymentReceived,
    required this.paymentrecivedPercent,
    required this.outstandingPayment,
    required this.numberOfOverDue,
    required this.expense,
    required this.netProfit,
  });

  @override
  List<Object?> get props => [
    logoImageUrl,
    totalInvoice,
    numberOfInvoice,
    paymentReceived,
    paymentrecivedPercent,
    outstandingPayment,
    numberOfOverDue,
    expense,
    netProfit,
  ];
}
