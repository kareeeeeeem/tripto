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
