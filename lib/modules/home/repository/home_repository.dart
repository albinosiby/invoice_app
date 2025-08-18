import '../model/dashboard_model.dart';

class HomeRepository {
  Future<List<DashboardCardModel>> fetchDashboardCards() async {
    // Mocked data
    return [
      DashboardCardModel(
        totalInvoice: '72,300',
        paymentReceived: '56000',
        outstandingPayment: '12,800',
        expense: '92,00',
        netProfit: '39,000',
        numberOfOverDue: '5',
        numberOfInvoice: '14',
        paymentrecivedPercent: '+8.5',
      ),
    ];
  }

  Future<List<InvoiceDueModel>> fetchUpcomingDueInvoices() async {
    // Mocked data
    return [
      InvoiceDueModel(
        clientName: 'ABC Enterprises',
        invoiceNumber: '#INV-2041',
        dueDate: '08 Jul',
        amount: '₹ 12,800',
        status: 'Pending',
        daysDue: 'Due in 3 days',
      ),
      InvoiceDueModel(
        clientName: 'DFG Enterprises',
        invoiceNumber: '#INV-2043',
        dueDate: '06 Jul',
        amount: '₹ 25,800',
        status: 'Pending',
        daysDue: 'Due in 5 days',
      ),
    ];
  }
}
