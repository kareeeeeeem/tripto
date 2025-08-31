import 'package:equatable/equatable.dart';

abstract class GetTripEvent extends Equatable {
  const GetTripEvent();

  @override
  List<Object> get props => [];
}

class FetchTrips extends GetTripEvent {}

class FilterTripsByCategoryEvent extends GetTripEvent {
  final int categoryId;

  const FilterTripsByCategoryEvent({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}

class FilterTripsByDateEvent extends GetTripEvent {
  final DateTime selectedDate;

  const FilterTripsByDateEvent({required this.selectedDate});

  @override
  List<Object> get props => [selectedDate];
}

class FilterTripsByDateRangeEvent extends GetTripEvent {
  final DateTime startDate;
  final DateTime endDate;

  const FilterTripsByDateRangeEvent({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object> get props => [startDate, endDate];
}

class ChangeCurrentTripEvent extends GetTripEvent {
  final int newIndex;
  ChangeCurrentTripEvent(this.newIndex);
  @override
  List<Object> get props => [newIndex];
}

abstract class DateSelectionState {}

class DateSelectionInitial extends DateSelectionState {}

class DateSelectionSuccess extends DateSelectionState {
  final DateTime rangeStart;
  final DateTime rangeEnd;

  DateSelectionSuccess({required this.rangeStart, required this.rangeEnd});
}

class DateSelectionFailure extends DateSelectionState {
  final String error;

  DateSelectionFailure(this.error);
}

// <<<<<<< HEAD
// class FetchActivities extends GetTripEvent {
//   const FetchActivities();

//   @override
//   List<Object> get props => [];
// =======
// bloc/car_event.dart
abstract class CarEvent {}

class LoadCars extends CarEvent {
  final int category;
  final int subDestinationId;

  LoadCars({required this.subDestinationId, required this.category});
  // >>>>>>> 1eae211b14fc89bf7cd14d95a42497fdb24bae4c
}

abstract class TripEvent {}

class UpdatePersonCount extends TripEvent {
  final String tripId;
  final int newCount;

  UpdatePersonCount(this.tripId, this.newCount);
}

class UpdateCarPrice extends TripEvent {
  final String tripId;
  final double newCarPrice;

  UpdateCarPrice(this.tripId, this.newCarPrice);
}

class UpdateBasePricePerPerson extends TripEvent {
  final String tripId;
  final double newBasePrice;

  UpdateBasePricePerPerson(this.tripId, this.newBasePrice);
}
