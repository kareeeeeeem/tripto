import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/BookNow_OrderTrip/OrderTripEvent.dart';
import 'package:tripto/bloc&repo/BookNow_OrderTrip/OrderTripRepository.dart';
import 'package:tripto/bloc&repo/BookNow_OrderTrip/OrderTripState.dart';

class OrderTripBloc extends Bloc<OrderTripEvent, OrderTripState> {
  final OrderTripRepository repository;

  OrderTripBloc(this.repository) : super(OrderTripInitial()) {
    on<SubmitOrderTrip>((event, emit) async {
      emit(OrderTripLoading());
      try {
        final response = await repository.createOrderTrip(event.orderData);
        emit(OrderTripSuccess(response));
      } catch (e) {
        emit(OrderTripFailure(e.toString()));
      }
    });
  }
}
