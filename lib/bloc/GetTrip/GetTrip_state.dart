import 'package:equatable/equatable.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_model.dart';
import 'package:tripto/core/models/CarModel.dart';

abstract class GetTripState extends Equatable {
  const GetTripState();
  @override
  List<Object?> get props => [];
}

class GetTripInitial extends GetTripState {}

class GetTripLoading extends GetTripState {}

class GetTripLoaded extends GetTripState {
  final List<GetTripModel> trips;
  final int currentIndex;

  const GetTripLoaded(this.trips, this.currentIndex);

  @override
  List<Object?> get props => [trips, currentIndex];
}

class GetTripError extends GetTripState {
  final String message;
  const GetTripError({required this.message});
  @override
  List<Object?> get props => [message];
}

// bloc/car_state.dart
abstract class CarState {}

class CarInitial extends CarState {}

class CarLoading extends CarState {}

class CarLoaded extends CarState {
  final List<Carmodel> cars;
  CarLoaded(this.cars);
}

class CarError extends CarState {
  final String message;
  CarError(this.message);
}

class TripState {
  final Map<String, int> personsCountPerTrip; // عدد الأشخاص لكل رحلة حسب id
  final Map<String, double> carPricePerTrip; // سعر العربية لكل رحلة حسب id
  final Map<String, double> basePricePerTrip; // سعر الفرد لكل رحلة حسب id

  TripState({
    Map<String, int>? personsCountPerTrip,
    Map<String, double>? carPricePerTrip,
    Map<String, double>? basePricePerTrip,
  }) : personsCountPerTrip = personsCountPerTrip ?? {},
       carPricePerTrip = carPricePerTrip ?? {},
       basePricePerTrip = basePricePerTrip ?? {};

  // لحساب السعر الإجمالي لكل رحلة
  double totalPriceForTrip(String tripId) {
    final persons = personsCountPerTrip[tripId] ?? 1;
    final basePrice = basePricePerTrip[tripId] ?? 0;
    final carPrice = carPricePerTrip[tripId] ?? 0;
    return persons * basePrice + carPrice;
  }

  TripState copyWith({
    Map<String, int>? personsCountPerTrip,
    Map<String, double>? carPricePerTrip,
    Map<String, double>? basePricePerTrip,
  }) {
    return TripState(
      personsCountPerTrip: personsCountPerTrip ?? this.personsCountPerTrip,
      carPricePerTrip: carPricePerTrip ?? this.carPricePerTrip,
      basePricePerTrip: basePricePerTrip ?? this.basePricePerTrip,
    );
  }
}
