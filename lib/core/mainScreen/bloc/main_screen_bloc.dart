import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc() : super(MainScreenTabState(0)) {
    on<MainScreenTabChanged>((event, emit) {
      emit(MainScreenTabState(event.tabIndex));
    });
  }
}
