// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:invoice_app/modules/Invoices/model/add_invoice_model.dart';

// part 'invoice_state.dart';

// class InvoiceCubit extends Cubit<InvoiceState> {
//   InvoiceCubit() : super(InvoiceInitial());

//   void createNewInvoice() {
//     emit(InvoiceLoaded(Invoice(
//       id: 'INV00001',
//       clientId: '',
//       date: DateTime.now(),
//       items: [],
//     )));
//   }

//   void updateInvoice(Invoice invoice) {
//     if (state is InvoiceLoaded) {
//       emit(InvoiceLoaded(invoice));
//     }
//   }

//   void addItem(InvoiceItem item) {
//     if (state is InvoiceLoaded) {
//       final currentInvoice = (state as InvoiceLoaded).invoice;
//       final updatedItems = List<InvoiceItem>.from(currentInvoice.items)..add(item);
//       emit(InvoiceLoaded(currentInvoice.copyWith(items: updatedItems)));
//     }
//   }

//   void removeItem(String itemId) {
//     if (state is InvoiceLoaded) {
//       final currentInvoice = (state as InvoiceLoaded).invoice;
//       final updatedItems = currentInvoice.items.where((item) => item.id != itemId).toList();
//       emit(InvoiceLoaded(currentInvoice.copyWith(items: updatedItems)));
//     }
//   }

//   void updateDiscount(double discount) {
//     if (state is InvoiceLoaded) {
//       final currentInvoice = (state as InvoiceLoaded).invoice;
//       emit(InvoiceLoaded(currentInvoice.copyWith(discount: discount)));
//     }
//   }

//   void updateTaxRate(double taxRate) {
//     if (state is InvoiceLoaded) {
//       final currentInvoice = (state as InvoiceLoaded).invoice;
//       emit(InvoiceLoaded(currentInvoice.copyWith(taxRate: taxRate)));
//     }
//   }

//   void toggleMarkAsPaid(bool value) {
//     if (state is InvoiceLoaded) {
//       final currentInvoice = (state as InvoiceLoaded).invoice;
//       emit(InvoiceLoaded(currentInvoice.copyWith(markAsPaid: value)));
//     }
//   }

//   void toggleAcceptCardPayments(bool value) {
//     if (state is InvoiceLoaded) {
//       final currentInvoice = (state as InvoiceLoaded).invoice;
//       emit(InvoiceLoaded(currentInvoice.copyWith(acceptCardPayments: value)));
//     }
//   }

//   void toggleRequestSignature(bool value) {
//     if (state is InvoiceLoaded) {
//       final currentInvoice = (state as InvoiceLoaded).invoice;
//       emit(InvoiceLoaded(currentInvoice.copyWith(requestSignature: value)));
//     }
//   }

//   void updateNotes(String notes) {
//     if (state is InvoiceLoaded) {
//       final currentInvoice = (state as InvoiceLoaded).invoice;
//       emit(InvoiceLoaded(currentInvoice.copyWith(notes: notes)));
//     }
//   }

//   void saveInvoice() {
//     if (state is InvoiceLoaded) {
//       final invoice = (state as InvoiceLoaded).invoice;
//       // Here you would typically save to repository
//       emit(InvoiceSaved(invoice));
//     }
//   }
// }
