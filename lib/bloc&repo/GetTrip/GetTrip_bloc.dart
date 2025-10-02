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
    // ✅ تعيين المعالج الصحيح لفلترة التاريخ المفرد
    on<FilterTripsByDateEvent>(_onFilterByDate); 
    
    // ✅ تعيين المعالج الصحيح لفلترة نطاق التاريخ
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
      return _isDateAvailable(
        event.selectedDate,
        trip.fromDate, // قائمة تواريخ البداية
        trip.toDate,   // قائمة تواريخ النهاية
      );
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
    return _isRangeOverlapping(
        event.startDate,
        event.endDate,
        trip.fromDate,
        trip.toDate,
      );
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



}// 🆕 دالة مساعدة للتحقق من توفر تاريخ معين
bool _isDateAvailable(
  DateTime selectedDate,
  List<String> fromDates,
  List<String> toDates,
) {
  for (int i = 0; i < fromDates.length; i++) {
    try {
      final start = DateTime.parse(fromDates[i]);
      final end = DateTime.parse(toDates[i]);
      
      // نستخدم isAfter و isBefore لضمان شمولية اليوم المختار
      if (selectedDate.isAfter(start.subtract(const Duration(days: 1))) &&
          selectedDate.isBefore(end.add(const Duration(days: 1)))) {
        return true;
      }
    } catch (e) {
      // تجاهل التاريخ غير الصالح
      continue;
    }
  }
  return false;
}




// 🆕 دالة مساعدة للتحقق من تداخل نطاق التواريخ
bool _isRangeOverlapping(
  DateTime selectedStart,
  DateTime selectedEnd,
  List<String> fromDates,
  List<String> toDates,
) {
  // نطاق المستخدم (M)
  final M_start = selectedStart;
  final M_end = selectedEnd;

  for (int i = 0; i < fromDates.length; i++) {
    try {
      // نطاق الرحلة المتاح (A)
      final A_start = DateTime.parse(fromDates[i]);
      final A_end = DateTime.parse(toDates[i]);

      // شرط عدم التداخل: A ينتهي قبل M يبدأ، أو A يبدأ بعد M ينتهي.
      // وبالتالي شرط التداخل هو:
      if (A_end.isAfter(M_start.subtract(const Duration(days: 1))) &&
          A_start.isBefore(M_end.add(const Duration(days: 1)))) {
        return true;
      }
    } catch (e) {
      // تجاهل التاريخ غير الصالح
      continue;
    }
  }
  return false;
}