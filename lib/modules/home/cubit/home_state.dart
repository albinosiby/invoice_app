import 'package:equatable/equatable.dart';
import 'package:invoice_app/modules/home/model/dashboard_model.dart';
import 'package:invoice_app/modules/home/model/invoice_due_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<DashboardCardModel> dashboardCards;
  final List<InvoiceDueModel> dueInvoices;
  const HomeLoaded({required this.dashboardCards, required this.dueInvoices});
  @override
  List<Object> get props => [dashboardCards, dueInvoices];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
  @override
  List<Object> get props => [message];
}

// States for navigation
class NavigateToSettings extends HomeState {}

class NavigateToCreateInvoice extends HomeState {}

class NavigateToAddEstimate extends HomeState {}

// States for actions that show feedback (like a snackbar)
class ReminderSentSuccess extends HomeState {
  final String invoiceNumber;
  const ReminderSentSuccess(this.invoiceNumber);
  @override
  List<Object> get props => [invoiceNumber];
}

class PaymentRecordedSuccess extends HomeState {
  final String invoiceNumber;
  const PaymentRecordedSuccess(this.invoiceNumber);
  @override
  List<Object> get props => [invoiceNumber];
}
