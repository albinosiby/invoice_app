import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;

  HomeBloc(this.repository) : super(HomeInitial()) {
    on<LoadHomeData>((event, emit) async {
      emit(HomeLoading());
      try {
        final dashboardCards = await repository.fetchDashboardCards();
        final dueInvoices = await repository.fetchUpcomingDueInvoices();
        emit(HomeLoaded(dashboardCards, dueInvoices));
      } catch (e) {
        emit(HomeError('Failed to load data'));
      }
    });
  }
}
