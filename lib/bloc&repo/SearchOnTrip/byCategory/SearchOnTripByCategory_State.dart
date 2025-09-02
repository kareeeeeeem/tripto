import 'package:tripto/bloc&repo/GetTrip/GetTrip_model.dart';

abstract class CategoryTripState {}

class CategoryTripInitial extends CategoryTripState {}

class CategoryTripLoading extends CategoryTripState {}

class CategoryTripLoaded extends CategoryTripState {
  final List<GetTripModel> trips;
  CategoryTripLoaded(this.trips);
}

class CategoryTripError extends CategoryTripState {
  final String message;
  CategoryTripError(this.message);
}
