import 'package:equatable/equatable.dart';

abstract class OrderTripEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitOrderTrip extends OrderTripEvent {
  final Map<String, dynamic> orderData;

  SubmitOrderTrip(this.orderData);

  @override
  List<Object?> get props => [orderData];
}
