abstract class CarEvent {}

class LoadCars extends CarEvent {
  final int category;
  final int subDestinationId;
  LoadCars({required this.subDestinationId, required this.category});
}
