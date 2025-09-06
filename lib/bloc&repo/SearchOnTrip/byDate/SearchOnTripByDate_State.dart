import 'package:equatable/equatable.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_model.dart';

abstract class SearchTripByDateState extends Equatable {
  const SearchTripByDateState();

  @override
  List<Object?> get props => [];
}

class SearchTripByDateInitial extends SearchTripByDateState {}

class SearchTripByDateLoading extends SearchTripByDateState {}

class SearchTripByDateLoaded extends SearchTripByDateState {
  final List<GetTripModel> trips;

  const SearchTripByDateLoaded(this.trips);

  @override
  List<Object?> get props => [trips];
}

class SearchTripByDateError extends SearchTripByDateState {
  final String message;

  const SearchTripByDateError(this.message);

  @override
  List<Object?> get props => [message];
}