class DashboardCardModel {
  final String totalInvoice;
  final String paymentReceived;
  final String outstandingPayment;
  final String expense;
  final String netProfit;
  final String numberOfInvoice;
  final String numberOfOverDue;
  final String paymentrecivedPercent;

  DashboardCardModel({
    required this.totalInvoice,
    required this.paymentReceived,
    required this.outstandingPayment,
    required this.expense,
    required this.netProfit,
    required this.numberOfInvoice,
    required this.numberOfOverDue,
    required this.paymentrecivedPercent,
  });
}

class InvoiceDueModel {
  final String clientName;
  final String invoiceNumber;
  final String dueDate;
  final String amount;
  final String status;
  final String daysDue;

  InvoiceDueModel({
    required this.clientName,
    required this.invoiceNumber,
    required this.dueDate,
    required this.amount,
    required this.status,
    required this.daysDue,
  });
}
