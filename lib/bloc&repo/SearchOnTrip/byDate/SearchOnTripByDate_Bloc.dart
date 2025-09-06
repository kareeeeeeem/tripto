import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byDate/SearchOnTripByDate_Event.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byDate/SearchOnTripByDate_State.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byDate/SearchOnTripByDate_repository.dart';

class SearchTripByDateBloc extends Bloc<SearchTripByDateEvent, SearchTripByDateState> {
  final SearchTripByDateRepository repository;

  SearchTripByDateBloc({required this.repository}) : super(SearchTripByDateInitial()) {
    on<FetchTripsByDate>((event, emit) async {
      emit(SearchTripByDateLoading());
      try {
        final trips = await repository.fetchTripsByDate(event.from, event.to);
        emit(SearchTripByDateLoaded(trips));
      } catch (e) {
        emit(SearchTripByDateError(e.toString()));
      }
    });
  }
}