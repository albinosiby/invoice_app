import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_app/modules/Invoices/model/invoice_model.dart';
import 'package:invoice_app/modules/Invoices/repository/invoice_repository.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  final InvoiceRepository repository;

  InvoiceCubit({required this.repository}) : super(InvoiceInitial());

  Future<void> loadInvoices() async {
    emit(InvoiceLoading());
    try {
      final invoices = await repository.getInvoices();
      emit(InvoiceLoaded(invoices: invoices));
    } catch (e) {
      emit(InvoiceError(message: 'Failed to load invoices: $e'));
    }
  }

  Future<void> filterInvoicesByStatus(String status) async {
    if (state is InvoiceLoaded) {
      final currentState = state as InvoiceLoaded;
      emit(InvoiceLoading());
      try {
        final invoices = status == 'All'
            ? await repository.getInvoices()
            : await repository.getInvoicesByStatus(status);
        emit(InvoiceLoaded(invoices: invoices, selectedFilter: status));
      } catch (e) {
        emit(InvoiceError(message: 'Failed to filter invoices: $e'));
        // Revert to previous state on error
        emit(currentState);
      }
    }
  }

  Future<void> searchInvoices(String query) async {
    if (state is InvoiceLoaded) {
      final currentState = state as InvoiceLoaded;
      emit(InvoiceLoading());
      try {
        final invoices = await repository.searchInvoices(query);
        emit(
          InvoiceLoaded(
            invoices: invoices,
            selectedFilter: currentState.selectedFilter,
            searchQuery: query,
          ),
        );
      } catch (e) {
        emit(InvoiceError(message: 'Failed to search invoices: $e'));
        // Revert to previous state on error
        emit(currentState);
      }
    }
  }

  Future<void> addInvoice(Invoice invoice) async {
    if (state is InvoiceLoaded) {
      final currentState = state as InvoiceLoaded;
      try {
        await repository.addInvoice(invoice);
        final invoices = await repository.getInvoices();
        emit(
          InvoiceLoaded(
            invoices: invoices,
            selectedFilter: currentState.selectedFilter,
            searchQuery: currentState.searchQuery,
          ),
        );
      } catch (e) {
        emit(InvoiceError(message: 'Failed to add invoice: $e'));
        emit(currentState);
      }
    }
  }

  Future<void> updateInvoice(Invoice invoice) async {
    if (state is InvoiceLoaded) {
      final currentState = state as InvoiceLoaded;
      try {
        await repository.updateInvoice(invoice);
        final invoices = await repository.getInvoices();
        emit(
          InvoiceLoaded(
            invoices: invoices,
            selectedFilter: currentState.selectedFilter,
            searchQuery: currentState.searchQuery,
          ),
        );
      } catch (e) {
        emit(InvoiceError(message: 'Failed to update invoice: $e'));
        emit(currentState);
      }
    }
  }

  Future<void> deleteInvoice(String id) async {
    if (state is InvoiceLoaded) {
      final currentState = state as InvoiceLoaded;
      try {
        await repository.deleteInvoice(id);
        final invoices = await repository.getInvoices();
        emit(
          InvoiceLoaded(
            invoices: invoices,
            selectedFilter: currentState.selectedFilter,
            searchQuery: currentState.searchQuery,
          ),
        );
      } catch (e) {
        emit(InvoiceError(message: 'Failed to delete invoice: $e'));
        emit(currentState);
      }
    }
  }
}
