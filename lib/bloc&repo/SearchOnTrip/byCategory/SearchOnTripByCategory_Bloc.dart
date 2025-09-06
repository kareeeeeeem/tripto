import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byCategory/SearchOnTripByCategory_Event.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byCategory/SearchOnTripByCategory_State.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byCategory/SearchOnTripByCategory_repository.dart';

class SearchTripByCategoryBloc
    extends Bloc<SearchTripByCategoryEvent, SearchTripByCategoryState> {
  final SearchTripByCategoryRepository repository;

  SearchTripByCategoryBloc({required this.repository})
      : super(SearchTripByCategoryInitial()) {
    on<FetchTripsByCategory>((event, emit) async {
      emit(SearchTripByCategoryLoading());
      try {
        final trips = await repository.fetchTripsByCategory(event.category);
        emit(SearchTripByCategoryLoaded(trips: trips));
      } catch (e) {
        emit(SearchTripByCategoryError(message: e.toString()));
      }
    });
  }
}
