import 'package:equatable/equatable.dart';

abstract class FilteredTripsEvent extends Equatable {
  const FilteredTripsEvent();
  @override
  List<Object?> get props => [];
}

class FilterTripsByDateRangeEvent extends FilteredTripsEvent {
  final DateTime startDate;
  final DateTime endDate;
  const FilterTripsByDateRangeEvent(this.startDate, this.endDate);

  @override
  List<Object?> get props => [startDate, endDate];
}
