// lib/modules/Clients/cubit/client_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:invoice_app/modules/Clients/model/client_model.dart';
import 'package:invoice_app/modules/Clients/repository/client_repository.dart';

part 'client_state.dart';

class ClientCubit extends Cubit<ClientState> {
  final ClientRepository clientRepository;

  ClientCubit({required this.clientRepository}) : super(ClientInitial());

  Future<void> loadClients() async {
    emit(ClientLoading());
    try {
      final clients = await clientRepository.getClients();
      emit(ClientLoaded(clients: clients));
    } catch (e) {
      emit(ClientError(message: e.toString()));
    }
  }

  Future<void> addClient(Client client) async {
    emit(ClientLoading());
    try {
      final newClient = await clientRepository.addClient(client);
      final currentState = state;
      if (currentState is ClientLoaded) {
        emit(ClientLoaded(clients: [...currentState.clients, newClient]));
      } else {
        await loadClients();
      }
    } catch (e) {
      emit(ClientError(message: e.toString()));
    }
  }

  Future<void> updateClient(Client client) async {
    emit(ClientLoading());
    try {
      final updatedClient = await clientRepository.updateClient(client);
      final currentState = state;
      if (currentState is ClientLoaded) {
        final updatedClients = currentState.clients
            .map((c) => c.id == updatedClient.id ? updatedClient : c)
            .toList();
        emit(ClientLoaded(clients: updatedClients));
      } else {
        await loadClients();
      }
    } catch (e) {
      emit(ClientError(message: e.toString()));
    }
  }

  Future<void> deleteClient(String id) async {
    emit(ClientLoading());
    try {
      await clientRepository.deleteClient(id);
      final currentState = state;
      if (currentState is ClientLoaded) {
        final updatedClients = currentState.clients
            .where((client) => client.id != id)
            .toList();
        emit(ClientLoaded(clients: updatedClients));
      } else {
        await loadClients();
      }
    } catch (e) {
      emit(ClientError(message: e.toString()));
    }
  }
}
