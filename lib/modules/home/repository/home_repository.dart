// file: lib/modules/home/repository/home_repository.dart

import '../model/dashboard_model.dart';
import '../model/invoice_due_model.dart';

class HomeRepository {
  /// Fetches the summary data for the dashboard cards.
  /// In a real app, this would make an API call.
  Future<List<DashboardCardModel>> getDashboardData() async {
    // Simulate a network delay
    //await Future.delayed(const Duration(seconds: 2));

    // Return mock data
    return const [
      DashboardCardModel(
        logoImageUrl:
            'https://i.pinimg.com/originals/70/25/55/70255539e6d3d249ea02ce7425db999a.jpg',
        totalInvoice: 250000.00,
        numberOfInvoice: 12,
        paymentReceived: 180000.00,
        paymentrecivedPercent: 15,
        outstandingPayment: 70000.00,
        numberOfOverDue: 3,
        expense: 45000.00,
        netProfit: 135000.00,
      ),
    ];
  }

  /// Fetches the list of upcoming due invoices.
  /// In a real app, this would make an API call.
  Future<List<InvoiceDueModel>> getDueInvoices() async {
    // Simulate a network delay
    //await Future.delayed(const Duration(seconds: 1));

    // Return a list of mock invoices
    return const [
      InvoiceDueModel(
        id: 'inv-001',
        clientName: 'Innovate Corp',
        invoiceNumber: '#INV-2025-001',
        amount: '₹45,000',
        status: 'Due',
        daysDue: 'in 5 days',
        dueDate: '23 Aug 2025',
      ),
      InvoiceDueModel(
        id: 'inv-002',
        clientName: 'Quantum Solutions',
        invoiceNumber: '#INV-2025-002',
        amount: '₹15,000',
        status: 'Due',
        daysDue: 'in 10 days',
        dueDate: '28 Aug 2025',
      ),
      InvoiceDueModel(
        id: 'inv-003',
        clientName: 'Apex Industries',
        invoiceNumber: '#INV-2025-003',
        amount: '₹10,000',
        status: 'Overdue',
        daysDue: 'by 2 days',
        dueDate: '16 Aug 2025',
      ),
    ];
  }
}
