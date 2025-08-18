part of 'main_screen_bloc.dart';

@immutable
sealed class MainScreenEvent {}

class MainScreenTabChanged extends MainScreenEvent {
  final int tabIndex;
  MainScreenTabChanged(this.tabIndex);
}
