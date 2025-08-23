// lib/modules/Clients/cubit/client_state.dart
part of 'client_cubit.dart';

abstract class ClientState {
  const ClientState();
}

class ClientInitial extends ClientState {}

class ClientLoading extends ClientState {}

class ClientLoaded extends ClientState {
  final List<Client> clients;

  const ClientLoaded({required this.clients});
}

class ClientError extends ClientState {
  final String message;

  const ClientError({required this.message});
}
