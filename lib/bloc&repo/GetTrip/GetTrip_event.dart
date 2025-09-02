import 'package:equatable/equatable.dart';

abstract class TripEvent extends Equatable {
  const TripEvent();
  @override
  List<Object?> get props => [];
}

class FetchTrips extends TripEvent {}

class FilterTripsByCategoryEvent extends TripEvent {
  final int categoryId;
  const FilterTripsByCategoryEvent(this.categoryId);
  @override
  List<Object?> get props => [categoryId];
}

class FilterTripsByDateEvent extends TripEvent {
  final DateTime selectedDate;
  const FilterTripsByDateEvent(this.selectedDate);
  @override
  List<Object?> get props => [selectedDate];
}

class FilterTripsByDateRangeEvent extends TripEvent {
  final DateTime startDate;
  final DateTime endDate;
  const FilterTripsByDateRangeEvent(this.startDate, this.endDate);
  @override
  List<Object?> get props => [startDate, endDate];
}

class ChangeCurrentTripEvent extends TripEvent {
  final int newIndex;
  const ChangeCurrentTripEvent(this.newIndex);
  @override
  List<Object?> get props => [newIndex];
}
