import 'package:equatable/equatable.dart';
import 'order_trip_model.dart';

abstract class OrderTripSearcMyTripsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderTripSearcMyTripsInitial extends OrderTripSearcMyTripsState {}

class OrderTripSearcMyTripsLoading extends OrderTripSearcMyTripsState {}

class OrderTripSearcMyTripsLoaded extends OrderTripSearcMyTripsState {
  final List<OrderTripSearcMyTrips> trips;

  OrderTripSearcMyTripsLoaded(this.trips);

  @override
  List<Object?> get props => [trips];
}

class OrderTripSearcMyTripsError extends OrderTripSearcMyTripsState {
  final String message;

  OrderTripSearcMyTripsError(this.message);

  @override
  List<Object?> get props => [message];
}
