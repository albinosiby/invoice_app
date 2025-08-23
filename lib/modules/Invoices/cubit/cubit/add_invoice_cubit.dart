// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:invoice_app/modules/Invoices/model/add_invoice_model.dart';
// import 'package:invoice_app/modules/Invoices/repository/invoice_repository.dart';

// part 'add_invoice_state.dart';

// class AddInvoiceCubit extends Cubit<AddInvoiceState> {
//   final InvoiceRepository repository;

//   AddInvoiceCubit({required this.repository}) : super(AddInvoiceInitial());

//   void createNewInvoice() {
//     emit(AddInvoiceLoaded(AddInvoices(
//       id: 'INV00001',
//       clientId: '',
//       date: DateTime.now(),
//       items: [],
//     )));
//   }

//   void updateInvoice(AddInvoices invoice) {
//     if (state is AddInvoiceLoaded) {
//       emit(AddInvoiceLoaded(invoice));
//     }
//   }

//   void addItem(InvoiceItem item) {
//     if (state is AddInvoiceLoaded) {
//       final currentInvoice = (state as AddInvoiceLoaded).invoice;
//       final updatedItems = List<InvoiceItem>.from(currentInvoice.items)..add(item);
//       emit(AddInvoiceLoaded(currentInvoice.copyWith(items: updatedItems)));
//     }
//   }

//   void removeItem(String itemId) {
//     if (state is AddInvoiceLoaded) {
//       final currentInvoice = (state as AddInvoiceLoaded).invoice;
//       final updatedItems = currentInvoice.items.where((item) => item.id != itemId).toList();
//       emit(AddInvoiceLoaded(currentInvoice.copyWith(items: updatedItems)));
//     }
//   }

//   void updateDiscount(double discount) {
//     if (state is AddInvoiceLoaded) {
//       final currentInvoice = (state as AddInvoiceLoaded).invoice;
//       emit(AddInvoiceLoaded(currentInvoice.copyWith(discount: discount)));
//     }
//   }

//   void updateTaxRate(double taxRate) {
//     if (state is AddInvoiceLoaded) {
//       final currentInvoice = (state as AddInvoiceLoaded).invoice;
//       emit(AddInvoiceLoaded(currentInvoice.copyWith(taxRate: taxRate)));
//     }
//   }

//   void toggleMarkAsPaid(bool value) {
//     if (state is AddInvoiceLoaded) {
//       final currentInvoice = (state as AddInvoiceLoaded).invoice;
//       emit(AddInvoiceLoaded(currentInvoice.copyWith(markAsPaid: value)));
//     }
//   }

//   void toggleAcceptCardPayments(bool value) {
//     if (state is AddInvoiceLoaded) {
//       final currentInvoice = (state as AddInvoiceLoaded).invoice;
//       emit(AddInvoiceLoaded(currentInvoice.copyWith(acceptCardPayments: value)));
//     }
//   }

//   void toggleRequestSignature(bool value) {
//     if (state is AddInvoiceLoaded) {
//       final currentInvoice = (state as AddInvoiceLoaded).invoice;
//       emit(AddInvoiceLoaded(currentInvoice.copyWith(requestSignature: value)));
//     }
//   }

//   void updateNotes(String notes) {
//     if (state is AddInvoiceLoaded) {
//       final currentInvoice = (state as AddInvoiceLoaded).invoice;
//       emit(AddInvoiceLoaded(currentInvoice.copyWith(notes: notes)));
//     }
//   }

//   void saveInvoice() {
//     if (state is AddInvoiceLoaded) {
//       final invoice = (state as AddInvoiceLoaded).invoice;
//       // Here you would typically save to repository
//       emit(AddInvoiceSaved(invoice));
//     }
//   }
// }
