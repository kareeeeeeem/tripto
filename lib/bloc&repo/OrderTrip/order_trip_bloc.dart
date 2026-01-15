import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/OrderTrip/order_trip_repository.dart';
import 'order_trip_event.dart';
import 'order_trip_state.dart';

class OrderTripSearcMyTripsBloc
    extends Bloc<OrderTripSearcMyTripsEvent, OrderTripSearcMyTripsState> {
  final OrderTripSearcMyTripsRepository repository;

  OrderTripSearcMyTripsBloc(this.repository)
      : super(OrderTripSearcMyTripsInitial()) {
    on<FetchUserTrips>((event, emit) async {
      emit(OrderTripSearcMyTripsLoading());

      try {
        if (event.userId == null) {
          emit(OrderTripSearcMyTripsError("Please login to see your trips"));
          return;
        }

        final trips = await repository.fetchUserTrips(event.userId);
        emit(OrderTripSearcMyTripsLoaded(trips));
      } catch (e) {
        emit(OrderTripSearcMyTripsError(e.toString()));
      }
    });
  }
}
