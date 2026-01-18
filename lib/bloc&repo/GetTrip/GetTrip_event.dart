import 'package:equatable/equatable.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_model.dart';

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





class SetTripsEvent extends TripEvent {
  final List<GetTripModel> trips;
  const SetTripsEvent(this.trips);
}


class SelectHotelForTrip extends TripEvent {
  final int tripId;
  final int hotelId;
  const SelectHotelForTrip(this.tripId, this.hotelId);
}

class SelectCarForTrip extends TripEvent {
  final int tripId;
  final int carId;
  const SelectCarForTrip(this.tripId, this.carId);
}

class SelectActivityForTrip extends TripEvent {
  final int tripId;
  final int activityId;
  const SelectActivityForTrip(this.tripId, this.activityId);
}

class SelectCategoryForTrip extends TripEvent {
  final int tripId;
  final int categoryValue;
  const SelectCategoryForTrip(this.tripId, this.categoryValue);
}

