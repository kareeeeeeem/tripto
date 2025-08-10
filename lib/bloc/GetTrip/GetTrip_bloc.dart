import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_event.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_model.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_state.dart';
import 'package:tripto/data/repositories/TripsRepository.dart';

class GetTripBloc extends Bloc<GetTripEvent, GetTripState> {
  final TripsRepository tripRepository;
  List<GetTripModel> allTrips = []; // نحتاج لتخزين جميع الرحلات للتصفية
  int currentIndex = 0;

  GetTripBloc(this.tripRepository) : super(GetTripInitial()) {
    on<FetchTrips>((event, emit) async {
      emit(GetTripLoading());
      try {
        allTrips = await tripRepository.fetchTrips();
        currentIndex = 0;
        emit(GetTripLoaded(allTrips, currentIndex));
      } catch (e) {
        emit(GetTripError(message: e.toString()));
      }
    });

    on<ChangeCurrentTripEvent>((event, emit) {
      currentIndex = event.newIndex;
      emit(GetTripLoaded(allTrips, currentIndex));
    });

    on<FilterTripsByCategoryEvent>((event, emit) {
      if (allTrips.isEmpty) return;

      final filteredTrips =
          allTrips.where((trip) => trip.category == event.categoryId).toList();

      emit(GetTripLoaded(filteredTrips, 0));
    });

    on<FilterTripsByDateEvent>((event, emit) {
      if (allTrips.isEmpty) return;

      final filteredTrips =
          allTrips.where((trip) {
            final tripStart = DateTime.parse(trip.fromDate);
            final tripEnd = DateTime.parse(trip.toDate);
            return event.selectedDate.isAfter(
                  tripStart.subtract(const Duration(days: 1)),
                ) &&
                event.selectedDate.isBefore(
                  tripEnd.add(const Duration(days: 1)),
                );
          }).toList();

      emit(GetTripLoaded(filteredTrips, 0));
    });

    on<FilterTripsByDateRangeEvent>((event, emit) {
      if (allTrips.isEmpty) return;

      final filteredTrips =
          allTrips.where((trip) {
            final tripStart = DateTime.parse(trip.fromDate);
            final tripEnd = DateTime.parse(trip.toDate);

            // الشرط ده بيضمن إن الرحلة بتتداخل مع المدى المحدد
            final overlaps =
                tripStart.isBefore(
                  event.endDate.add(const Duration(days: 1)),
                ) &&
                tripEnd.isAfter(
                  event.startDate.subtract(const Duration(days: 1)),
                );

            return overlaps;
          }).toList();

      emit(GetTripLoaded(filteredTrips, 0));
    });
  }
}

abstract class DateSelectionEvent {}

class DateRangeSelected extends DateSelectionEvent {
  final DateTime rangeStart;
  final DateTime rangeEnd;

  DateRangeSelected(this.rangeStart, this.rangeEnd);
}

abstract class DateSelectionState {}

class DateSelectionInitial extends DateSelectionState {}

class DateSelectionSuccess extends DateSelectionState {
  final DateTime rangeStart;
  final DateTime rangeEnd;

  DateSelectionSuccess(this.rangeStart, this.rangeEnd);
}

class DateSelectionFailure extends DateSelectionState {
  final String error;

  DateSelectionFailure(this.error);
}

class DateSelectionBloc extends Bloc<DateSelectionEvent, DateSelectionState> {
  DateSelectionBloc() : super(DateSelectionInitial()) {
    on<DateRangeSelected>((event, emit) async {
      try {
        if (event.rangeStart.isAfter(event.rangeEnd)) {
          emit(
            DateSelectionFailure("تاريخ البداية يجب أن يكون قبل تاريخ النهاية"),
          );
          return;
        }

        await Future.delayed(const Duration(milliseconds: 300));
        emit(DateSelectionSuccess(event.rangeStart, event.rangeEnd));
      } catch (e) {
        emit(DateSelectionFailure("حدث خطأ في اختيار التاريخ"));
      }
    });
  }
}

// bloc/car_bloc.dart

class CarBloc extends Bloc<CarEvent, CarState> {
  final CarRepository carRepository;

  CarBloc({required this.carRepository}) : super(CarInitial()) {
    on<LoadCars>((event, emit) async {
      emit(CarLoading());
      try {
        // نعطي فرصة للـ repo يفلتر عن طريق params لو يدعم
        final cars = await carRepository.fetchCars(
          subDestinationId: event.subDestinationId,
          category: event.category,
        );

        emit(CarLoaded(cars));
      } catch (e) {
        emit(CarError(e.toString()));
      }
    });
  }
}
