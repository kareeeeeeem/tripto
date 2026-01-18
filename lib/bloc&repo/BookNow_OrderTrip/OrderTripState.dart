import 'package:equatable/equatable.dart';

abstract class OrderTripState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderTripInitial extends OrderTripState {}

class OrderTripLoading extends OrderTripState {}

class OrderTripSuccess extends OrderTripState {
  final Map<String, dynamic> response;

  OrderTripSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class OrderTripFailure extends OrderTripState {
  final String error;

  OrderTripFailure(this.error);

  @override
  List<Object?> get props => [error];
}
