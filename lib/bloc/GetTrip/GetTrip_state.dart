import 'package:equatable/equatable.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_model.dart';

abstract class GetTripState extends Equatable {
  const GetTripState();
  @override
  List<Object?> get props => [];
}

class GetTripInitial extends GetTripState {}

class GetTripLoading extends GetTripState {}

class GetTripLoaded extends GetTripState {
  final List<GetTripModel> trips;
  const GetTripLoaded(this.trips);
  @override
  List<Object?> get props => [trips];
}

class GetTripError extends GetTripState {
  final String message;
  const GetTripError({required this.message});
  @override
  List<Object?> get props => [message];
}
