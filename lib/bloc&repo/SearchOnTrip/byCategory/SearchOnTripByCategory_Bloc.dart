import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byCategory/SearchOnTripByCategory_Event.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byCategory/SearchOnTripByCategory_State.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byCategory/SearchOnTripByCategory_repository.dart';

class CategoryTripBloc extends Bloc<CategoryTripEvent, CategoryTripState> {
  final FilteredTripsByCategoryRepository repository;

  CategoryTripBloc(this.repository) : super(CategoryTripInitial()) {
    on<FetchTripsByCategoryEvent>((event, emit) async {
      emit(CategoryTripLoading());
      try {
        final trips = await repository.fetchTripsByCategory(event.category);
        emit(CategoryTripLoaded(trips));
      } catch (e) {
        emit(CategoryTripError(e.toString()));
      }
    });
  }
}
