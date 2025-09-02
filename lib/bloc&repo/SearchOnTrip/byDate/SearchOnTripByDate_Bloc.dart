import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTrip_repository.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/searchontrip_Event.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/searchontrip_State.dart';

class FilteredTripsBloc extends Bloc<FilteredTripsEvent, FilteredTripsState> {
  final FilteredTripsRepository repo;

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
