import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byDate/SearchOnTripByDate_repository.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byDate/SearchOnTripByDate.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byDate/SearchOnTripByDate_State.dart';

class FilteredTripsBloc extends Bloc<FilteredTripsEvent, FilteredTripsState> {
  final FilteredTripsByDateRepository repo;

  FilteredTripsBloc(this.repo) : super(FilteredTripsInitial()) {
    on<FilterTripsByDateRangeEvent>(_onFilterByDateRange);
  }

  Future<void> _onFilterByDateRange(
    FilterTripsByDateRangeEvent event,
    Emitter<FilteredTripsState> emit,
  ) async {
    emit(FilteredTripsLoading());
    try {
      final filteredTrips = await repo.fetchTripsByDate(
        event.startDate,
        event.endDate,
      );
      emit(FilteredTripsLoaded(filteredTrips));
    } catch (e) {
      emit(FilteredTripsError('Failed to fetch filtered trips'));
    }
  }
}
