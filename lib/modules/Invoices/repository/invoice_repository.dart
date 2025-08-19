import 'package:invoice_app/modules/Invoices/model/invoice_model.dart';

abstract class InvoiceRepository {
  Future<List<Invoice>> getInvoices();
  Future<List<Invoice>> getInvoicesByStatus(String status);
  Future<List<Invoice>> searchInvoices(String query);
  Future<void> addInvoice(Invoice invoice);
  Future<void> updateInvoice(Invoice invoice);
  Future<void> deleteInvoice(String id);
}

class MockInvoiceRepository implements InvoiceRepository {
  final List<Invoice> _invoices = [
    Invoice(
      id: '1',
      clientName: 'ABC Enterprises',
      invoiceNumber: '#INV-2041',
      amount: 12800,
      status: 'Pending',
      dueDate: DateTime(2025, 7, 8),
      createdAt: DateTime(2025, 6, 20),
    ),
    Invoice(
      id: '2',
      clientName: 'XYZ Solutions',
      invoiceNumber: '#INV-2042',
      amount: 8500,
      status: 'Paid',
      dueDate: DateTime(2025, 7, 5),
      createdAt: DateTime(2025, 6, 15),
    ),
    Invoice(
      id: '3',
      clientName: 'Tech Innovations',
      invoiceNumber: '#INV-2043',
      amount: 15000,
      status: 'Overdue',
      dueDate: DateTime(2025, 7, 1),
      createdAt: DateTime(2025, 6, 10),
    ),
    Invoice(
      id: '4',
      clientName: 'Techz Innovations',
      invoiceNumber: '#INV-2043',
      amount: 15000,
      status: 'Overdue',
      dueDate: DateTime(2025, 7, 1),
      createdAt: DateTime(2025, 6, 10),
    ),
  ];

  @override
  Future<List<Invoice>> getInvoices() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _invoices;
  }

  @override
  Future<List<Invoice>> getInvoicesByStatus(String status) async {
    //await Future.delayed(const Duration(milliseconds: 300));
    return _invoices.where((invoice) => invoice.status == status).toList();
  }

  @override
  Future<List<Invoice>> searchInvoices(String query) async {
    //await Future.delayed(const Duration(milliseconds: 300));
    return _invoices
        .where(
          (invoice) =>
              invoice.clientName.toLowerCase().contains(query.toLowerCase()) ||
              invoice.invoiceNumber.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  @override
  Future<void> addInvoice(Invoice invoice) async {
    //await Future.delayed(const Duration(milliseconds: 200));
    _invoices.add(invoice);
  }

  @override
  Future<void> updateInvoice(Invoice invoice) async {
    //await Future.delayed(const Duration(milliseconds: 200));
    final index = _invoices.indexWhere((inv) => inv.id == invoice.id);
    if (index != -1) {
      _invoices[index] = invoice;
    }
  }

  @override
  Future<void> deleteInvoice(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _invoices.removeWhere((invoice) => invoice.id == id);
  }
}
