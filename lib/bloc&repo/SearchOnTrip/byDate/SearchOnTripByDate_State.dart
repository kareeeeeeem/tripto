import 'package:equatable/equatable.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_model.dart';

abstract class FilteredTripsState extends Equatable {
  const FilteredTripsState();
  @override
  List<Object?> get props => [];
}

class FilteredTripsInitial extends FilteredTripsState {}

class FilteredTripsLoading extends FilteredTripsState {}

class FilteredTripsLoaded extends FilteredTripsState {
  final List<GetTripModel> trips;
  const FilteredTripsLoaded(this.trips);

  @override
  List<Object?> get props => [trips];
}

class FilteredTripsError extends FilteredTripsState {
  final String message;
  const FilteredTripsError(this.message);

  @override
  List<Object?> get props => [message];
}
