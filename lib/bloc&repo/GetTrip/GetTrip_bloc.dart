import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_model.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_repository.dart';
import 'GetTrip_event.dart';
import 'GetTrip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final TripRepository repo;

  List<GetTripModel> allTrips = [];
  List<GetTripModel> currentTrips = [];
  int currentIndex = 0;

  TripBloc(this.repo) : super(TripInitial()) {
    on<FetchTrips>(_onFetchTrips);
    on<ChangeCurrentTripEvent>(_onChangeCurrentTrip);
    on<FilterTripsByCategoryEvent>(_onFilterByCategory);
    on<FilterTripsByDateEvent>(_onFilterByDate);
    on<FilterTripsByDateRangeEvent>(_onFilterByDateRange);
    on<SelectHotelForTrip>((event, emit) {
  if (state is TripLoaded) {
    final s = state as TripLoaded;
    final newSelections = Map<int, TripSelections>.from(s.selections);
    final current = newSelections[event.tripId] ?? TripSelections();
    newSelections[event.tripId] = current.copyWith(hotelId: event.hotelId);
    emit(s.copyWith(selections: newSelections));
  }
});

on<SelectCarForTrip>((event, emit) {
  if (state is TripLoaded) {
    final s = state as TripLoaded;
    final newSelections = Map<int, TripSelections>.from(s.selections);
    final current = newSelections[event.tripId] ?? TripSelections();
    newSelections[event.tripId] = current.copyWith(carId: event.carId);
    emit(s.copyWith(selections: newSelections));
  }
});

on<SelectActivityForTrip>((event, emit) {
  if (state is TripLoaded) {
    final s = state as TripLoaded;
    final newSelections = Map<int, TripSelections>.from(s.selections);
    final current = newSelections[event.tripId] ?? TripSelections();
    newSelections[event.tripId] = current.copyWith(activityId: event.activityId);
    emit(s.copyWith(selections: newSelections));
  }
});

on<SelectCategoryForTrip>((event, emit) {
  if (state is TripLoaded) {
    final s = state as TripLoaded;
    final newSelections = Map<int, TripSelections>.from(s.selections);
    final current = newSelections[event.tripId] ?? TripSelections();
    newSelections[event.tripId] = current.copyWith(categoryValue: event.categoryValue);
    emit(s.copyWith(selections: newSelections));
  }
});


    // ✅ استقبل رحلات من Search blocs
    on<SetTripsEvent>((event, emit) {
      currentTrips = event.trips;
      currentIndex = 0;
      if (state is TripLoaded) {
  final oldSelections = (state as TripLoaded).selections;
  final newSelections = <int, TripSelections>{};

  // فقط الرحلات اللي لسه موجودة بعد الفلترة نحافظ على حالتها
  for (var trip in currentTrips) {
    if (oldSelections.containsKey(trip.id)) {
      newSelections[trip.id] = oldSelections[trip.id]!;
    }
  }

  emit(TripLoaded(currentTrips, currentIndex, selections: newSelections));
} else {
  emit(TripLoaded(currentTrips, currentIndex, selections: {}));
}
    });
  }

  Future<void> _onFetchTrips(FetchTrips event, Emitter<TripState> emit) async {
    emit(TripLoading());
    try {
      allTrips = await repo.fetchTrips();
      currentTrips = allTrips;
      currentIndex = 0;
      if (state is TripLoaded) {
  final oldSelections = (state as TripLoaded).selections;
  final newSelections = <int, TripSelections>{};

  // فقط الرحلات اللي لسه موجودة بعد الفلترة نحافظ على حالتها
  for (var trip in currentTrips) {
    if (oldSelections.containsKey(trip.id)) {
      newSelections[trip.id] = oldSelections[trip.id]!;
    }
  }

  emit(TripLoaded(currentTrips, currentIndex, selections: newSelections));
} else {
  emit(TripLoaded(currentTrips, currentIndex, selections: {}));
}
    } catch (e) {
      emit(TripError('No Internet connection'));
    }
  }

  void _onChangeCurrentTrip(
    ChangeCurrentTripEvent event,
    Emitter<TripState> emit,
  ) {
    currentIndex = event.newIndex;
    if (state is TripLoaded) {
  final oldSelections = (state as TripLoaded).selections;
  final newSelections = <int, TripSelections>{};

  // فقط الرحلات اللي لسه موجودة بعد الفلترة نحافظ على حالتها
  for (var trip in currentTrips) {
    if (oldSelections.containsKey(trip.id)) {
      newSelections[trip.id] = oldSelections[trip.id]!;
    }
  }

  emit(TripLoaded(currentTrips, currentIndex, selections: newSelections));
} else {
  emit(TripLoaded(currentTrips, currentIndex, selections: {}));
}
  }

  void _onFilterByCategory(
    FilterTripsByCategoryEvent event,
    Emitter<TripState> emit,
  ) {
    final filtered = allTrips
        .where((trip) => trip.category == event.categoryId)
        .toList();

    currentTrips = filtered;
    currentIndex = 0;
    if (state is TripLoaded) {
  final oldSelections = (state as TripLoaded).selections;
  final newSelections = <int, TripSelections>{};

  // فقط الرحلات اللي لسه موجودة بعد الفلترة نحافظ على حالتها
  for (var trip in currentTrips) {
    if (oldSelections.containsKey(trip.id)) {
      newSelections[trip.id] = oldSelections[trip.id]!;
    }
  }

  emit(TripLoaded(currentTrips, currentIndex, selections: newSelections));
} else {
  emit(TripLoaded(currentTrips, currentIndex, selections: {}));
}
  }

  void _onFilterByDate(
    FilterTripsByDateEvent event,
    Emitter<TripState> emit,
  ) {
    final filtered = allTrips.where((trip) {
      final start = DateTime.parse(trip.fromDate);
      final end = DateTime.parse(trip.toDate);
      return event.selectedDate.isAfter(
            start.subtract(const Duration(days: 1)),
          ) &&
          event.selectedDate.isBefore(end.add(const Duration(days: 1)));
    }).toList();

    currentTrips = filtered;
    currentIndex = 0;
    if (state is TripLoaded) {
  final oldSelections = (state as TripLoaded).selections;
  final newSelections = <int, TripSelections>{};

  // فقط الرحلات اللي لسه موجودة بعد الفلترة نحافظ على حالتها
  for (var trip in currentTrips) {
    if (oldSelections.containsKey(trip.id)) {
      newSelections[trip.id] = oldSelections[trip.id]!;
    }
  }

  emit(TripLoaded(currentTrips, currentIndex, selections: newSelections));
} else {
  emit(TripLoaded(currentTrips, currentIndex, selections: {}));
}
  }

  void _onFilterByDateRange(
    FilterTripsByDateRangeEvent event,
    Emitter<TripState> emit,
  ) {
    final filtered = allTrips.where((trip) {
      final start = DateTime.parse(trip.fromDate);
      final end = DateTime.parse(trip.toDate);
      return start.isBefore(event.endDate.add(const Duration(days: 1))) &&
          end.isAfter(event.startDate.subtract(const Duration(days: 1)));
    }).toList();

    currentTrips = filtered;
    currentIndex = 0;
    if (state is TripLoaded) {
  final oldSelections = (state as TripLoaded).selections;
  final newSelections = <int, TripSelections>{};

  // فقط الرحلات اللي لسه موجودة بعد الفلترة نحافظ على حالتها
  for (var trip in currentTrips) {
    if (oldSelections.containsKey(trip.id)) {
      newSelections[trip.id] = oldSelections[trip.id]!;
    }
  }

  emit(TripLoaded(currentTrips, currentIndex, selections: newSelections));
} else {
  emit(TripLoaded(currentTrips, currentIndex, selections: {}));
}
  }
}
class TripSelections {
  final int? hotelId;
  final int? carId;
  final int? activityId;
  final int? categoryValue;

  TripSelections({
    this.hotelId,
    this.carId,
    this.activityId,
    this.categoryValue,
  });

  TripSelections copyWith({
    int? hotelId,
    int? carId,
    int? activityId,
    int? categoryValue,
  }) {
    return TripSelections(
      hotelId: hotelId ?? this.hotelId,
      carId: carId ?? this.carId,
      activityId: activityId ?? this.activityId,
      categoryValue: categoryValue ?? this.categoryValue,
    );
  }
}
