part of 'invoice_cubit.dart';

abstract class InvoiceState {
  const InvoiceState();
}

class InvoiceInitial extends InvoiceState {}

class InvoiceLoading extends InvoiceState {}

class InvoiceLoaded extends InvoiceState {
  final List<Invoice> invoices;
  final String selectedFilter;
  final String searchQuery;

  InvoiceLoaded({
    required this.invoices,
    this.selectedFilter = 'All',
    this.searchQuery = '',
  });
}

class InvoiceError extends InvoiceState {
  final String message;

  InvoiceError({required this.message});
}
