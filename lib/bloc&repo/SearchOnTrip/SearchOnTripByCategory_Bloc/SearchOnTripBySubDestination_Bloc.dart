import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTripByCategory_Bloc/SearchOnTripBySubDestination_Event.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTripByCategory_Bloc/SearchOnTripBySubDestination_State.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTripByCategory_Bloc/SearchOnTripBySubDestination_repository.dart';

class SearchSubDestinationBloc
    extends Bloc<SearchSubDestinationEvent, SearchSubDestinationState> {
  final SearchSubDestinationRepository repository;

  SearchSubDestinationBloc(this.repository)
    : super(SearchSubDestinationInitial()) {
    on<SearchSubDestinationRequested>((event, emit) async {
      emit(SearchSubDestinationLoading());
      try {
        final trips = await repository.searchSubDestination(event.query);
        emit(SearchSubDestinationLoaded(trips));
      } catch (e) {
        emit(SearchSubDestinationError(e.toString()));
      }
    });
  }
}
