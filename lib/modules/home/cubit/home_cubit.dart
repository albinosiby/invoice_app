// file: lib/modules/home/cubit/home_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_app/modules/home/cubit/home_state.dart';
import 'package:invoice_app/modules/home/model/dashboard_model.dart';
import 'package:invoice_app/modules/home/model/invoice_due_model.dart';
import 'package:invoice_app/modules/home/repository/home_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(HomeInitial());

  Future<void> fetchHomeData() async {
    try {
      emit(HomeLoading());
      final results = await Future.wait([
        _homeRepository.getDashboardData(),
        _homeRepository.getDueInvoices(),
      ]);
      emit(
        HomeLoaded(
          dashboardCards: results[0] as List<DashboardCardModel>,
          dueInvoices: results[1] as List<InvoiceDueModel>,
        ),
      );
    } catch (e) {
      emit(HomeError('Failed to load home data: $e'));
    }
  }

  // --- CORRECTED ACTION & NAVIGATION METHODS ---

  void goToSettings() {
    // This method causes navigation, so we don't need to revert the state.
    // The new screen will cover the old one.
    emit(NavigateToSettings());
  }

  void goToCreateInvoice() {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(NavigateToCreateInvoice());
      // Revert state so the UI doesn't see the action state and go blank.
      emit(currentState);
    }
  }

  void goToAddEstimate() {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(NavigateToAddEstimate());
      // Revert state.
      emit(currentState);
    }
  }

  void sendReminder(InvoiceDueModel invoice) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      print('Sending reminder for ${invoice.invoiceNumber}...');
      emit(ReminderSentSuccess(invoice.invoiceNumber));
      emit(currentState);
    }
  }

  void recordPaymentManually(InvoiceDueModel invoice) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      print('Recording payment for ${invoice.invoiceNumber}...');
      emit(PaymentRecordedSuccess(invoice.invoiceNumber));
      emit(currentState);
    }
  }
}
