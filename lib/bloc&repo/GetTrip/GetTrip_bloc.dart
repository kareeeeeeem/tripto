import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_model.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_repository.dart';
import 'GetTrip_event.dart';
import 'GetTrip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final TripRepository repo;
  List<GetTripModel> allTrips = [];
  int currentIndex = 0;

  TripBloc(this.repo) : super(TripInitial()) {
    on<FetchTrips>(_onFetchTrips);
    on<ChangeCurrentTripEvent>(_onChangeCurrentTrip);
    on<FilterTripsByCategoryEvent>(_onFilterByCategory);
    on<FilterTripsByDateEvent>(_onFilterByDate);
    on<FilterTripsByDateRangeEvent>(_onFilterByDateRange);
  }

  Future<void> _onFetchTrips(FetchTrips event, Emitter<TripState> emit) async {
    emit(TripLoading());
    try {
      allTrips = await repo.fetchTrips();
      currentIndex = 0;
      emit(TripLoaded(allTrips, currentIndex));
    } catch (e) {
      emit(TripError('No Internet connection'));
    }
  }

  void _onChangeCurrentTrip(
    ChangeCurrentTripEvent event,
    Emitter<TripState> emit,
  ) {
    currentIndex = event.newIndex;
    emit(TripLoaded(allTrips, currentIndex));
  }

  void _onFilterByCategory(
    FilterTripsByCategoryEvent event,
    Emitter<TripState> emit,
  ) {
    final filtered =
        allTrips.where((trip) => trip.category == event.categoryId).toList();
    emit(TripLoaded(filtered, 0));
  }

  void _onFilterByDate(FilterTripsByDateEvent event, Emitter<TripState> emit) {
    final filtered =
        allTrips.where((trip) {
          final start = DateTime.parse(trip.fromDate);
          final end = DateTime.parse(trip.toDate);
          return event.selectedDate.isAfter(
                start.subtract(const Duration(days: 1)),
              ) &&
              event.selectedDate.isBefore(end.add(const Duration(days: 1)));
        }).toList();
    emit(TripLoaded(filtered, 0));
  }

  void _onFilterByDateRange(
    FilterTripsByDateRangeEvent event,
    Emitter<TripState> emit,
  ) {
    final filtered =
        allTrips.where((trip) {
          final start = DateTime.parse(trip.fromDate);
          final end = DateTime.parse(trip.toDate);
          return start.isBefore(event.endDate.add(const Duration(days: 1))) &&
              end.isAfter(event.startDate.subtract(const Duration(days: 1)));
        }).toList();
    emit(TripLoaded(filtered, 0));
  }
}
