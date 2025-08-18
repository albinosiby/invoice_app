part of 'main_screen_bloc.dart';

@immutable
sealed class MainScreenState {}

final class MainScreenInitial extends MainScreenState {}

class MainScreenTabState extends MainScreenState {
  final int tabIndex;
  MainScreenTabState(this.tabIndex);
}
