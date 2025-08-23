// lib/modules/Clients/repository/client_repository.dart
import 'package:invoice_app/modules/Clients/model/client_model.dart';

abstract class ClientRepository {
  Future<List<Client>> getClients();
  Future<Client> addClient(Client client);
  Future<Client> updateClient(Client client);
  Future<void> deleteClient(String id);
  Future<Client> getClientById(String id);
}

class ClientRepositoryImpl implements ClientRepository {
  final List<Client> _clients = [];

  @override
  Future<List<Client>> getClients() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _clients;
  }

  @override
  Future<Client> addClient(Client client) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final newClient = client.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    _clients.add(newClient);
    return newClient;
  }

  @override
  Future<Client> updateClient(Client client) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _clients.indexWhere((c) => c.id == client.id);
    if (index != -1) {
      _clients[index] = client;
      return client;
    }
    throw Exception('Client not found');
  }

  @override
  Future<void> deleteClient(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _clients.removeWhere((client) => client.id == id);
  }

  @override
  Future<Client> getClientById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final client = _clients.firstWhere((client) => client.id == id);
    return client;
  }
}
