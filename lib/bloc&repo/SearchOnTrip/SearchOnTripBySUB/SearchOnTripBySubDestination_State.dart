import 'package:tripto/bloc&repo/GetTrip/GetTrip_model.dart';

abstract class SearchTripBySubDestinationState {}

class SearchTripBySubDestinationInitial extends SearchTripBySubDestinationState {}

class SearchTripBySubDestinationLoading extends SearchTripBySubDestinationState {}

class SearchTripBySubDestinationLoaded extends SearchTripBySubDestinationState {
  final List<GetTripModel> trips;
  SearchTripBySubDestinationLoaded({required this.trips});
}

class SearchTripBySubDestinationError extends SearchTripBySubDestinationState {
  final String message;
  SearchTripBySubDestinationError({required this.message});
}
