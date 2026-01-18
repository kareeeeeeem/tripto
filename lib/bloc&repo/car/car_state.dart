import 'package:tripto/core/models/CarModel.dart';

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

class GetAllCarsSuccess extends CarState {
  final List<Carmodel> allcars;

  GetAllCarsSuccess(this.allcars);

  // لو حابب تستخدم equatable بعدين
  // @override
  // List<Object?> get props => [allcars];
}
