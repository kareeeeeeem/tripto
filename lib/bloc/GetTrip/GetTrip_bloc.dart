import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_event.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_model.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_state.dart';
import 'package:tripto/data/repositories/TripsRepository.dart';

class GetTripBloc extends Bloc<GetTripEvent, GetTripState> {
  final TripsRepository tripRepository;
  List<GetTripModel> allTrips = []; // نحتاج لتخزين جميع الرحلات للتصفية

  GetTripBloc(this.tripRepository) : super(GetTripInitial()) {
    on<FetchTrips>((event, emit) async {
      emit(GetTripLoading());
      try {
        allTrips = await tripRepository.fetchTrips();
        emit(GetTripLoaded(allTrips));
      } catch (e) {
        emit(GetTripError(message: e.toString()));
      }
    });

    on<FilterTripsByCategoryEvent>((event, emit) {
      if (allTrips.isEmpty) return;

      final filteredTrips =
          allTrips.where((trip) => trip.category == event.categoryId).toList();

      emit(GetTripLoaded(filteredTrips));
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

      emit(GetTripLoaded(filteredTrips));
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

      emit(GetTripLoaded(filteredTrips));
    });
  }
}
