// file: lib/modules/settings/cubit/settings_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  // Methods to be called by the UI
  void goToAccountInfo() => emit(NavigateToAccountInfo());
  void goToSubscription() => emit(NavigateToSubscription());
  void goToBilling() => emit(NavigateToBilling());

  // You can add more navigation methods here...

  void logout() {
    // Here you would call a repository to clear user tokens
    print('Logging out...');
    emit(LoggedOut());
  }
}
