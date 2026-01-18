import 'package:equatable/equatable.dart';

abstract class CarEvent extends Equatable {
  const CarEvent();

  @override
  List<Object?> get props => [];
}

class LoadCars extends CarEvent {
  final int category;
  final int subDestinationId;
  LoadCars({required this.subDestinationId, required this.category});
}

class LoadAllCars extends CarEvent {
  const LoadAllCars();
  @override
  List<Object?> get props => [];
}
