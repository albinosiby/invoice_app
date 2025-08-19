// file: lib/modules/settings/cubit/settings_state.dart

part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

// States for each navigation action
class NavigateToAccountInfo extends SettingsState {}

class NavigateToSubscription extends SettingsState {}

class NavigateToBilling extends SettingsState {}

// State for the logout action
class LoggedOut extends SettingsState {}
