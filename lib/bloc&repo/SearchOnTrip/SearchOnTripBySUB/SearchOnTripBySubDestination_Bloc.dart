import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTripBySUB/SearchOnTripBySubDestination_Event.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTripBySUB/SearchOnTripBySubDestination_State.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTripBySUB/SearchOnTripBySubDestination_repository.dart';

class SearchTripBySubDestinationBloc extends Bloc<SearchTripBySubDestinationEvent, SearchTripBySubDestinationState> {
  final SearchTripBySubDestinationRepository repository;

  SearchTripBySubDestinationBloc({required this.repository})
      : super(SearchTripBySubDestinationInitial()) {
    on<FetchTripsBySubDestination>(_onFetchTripsBySubDestination);
  }

  Future<void> _onFetchTripsBySubDestination(
    FetchTripsBySubDestination event,
    Emitter<SearchTripBySubDestinationState> emit,
  ) async {
    emit(SearchTripBySubDestinationLoading());
    try {
      final trips = await repository.fetchTripsBySubDestination(event.subDestination);
      emit(SearchTripBySubDestinationLoaded(trips: trips));
    } catch (e) {
      emit(SearchTripBySubDestinationError(message: e.toString()));
    }
  }
}
