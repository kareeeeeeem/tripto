import 'package:equatable/equatable.dart';

abstract class OrderTripSearcMyTripsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUserTrips extends OrderTripSearcMyTripsEvent {
  final int userId;

  FetchUserTrips(this.userId);

  @override
  List<Object?> get props => [userId];
}
