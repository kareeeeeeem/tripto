import 'package:equatable/equatable.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_model.dart';

abstract class TripState extends Equatable {
  const TripState();
  @override
  List<Object?> get props => [];
}

class TripInitial extends TripState {}

class TripLoading extends TripState {}

class TripLoaded extends TripState {
  final List<GetTripModel> trips;
  final int currentIndex;
  const TripLoaded(this.trips, this.currentIndex);
  @override
  List<Object?> get props => [trips, currentIndex];
}

class TripError extends TripState {
  final String message;
  const TripError(this.message);
  @override
  List<Object?> get props => [message];
}
