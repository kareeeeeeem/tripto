import 'package:equatable/equatable.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_bloc.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_model.dart';

abstract class TripState extends Equatable {
  const TripState();
  @override
  List<Object?> get props => [];
}

class TripInitial extends TripState {}

class TripLoading extends TripState {}

class TripLoaded extends TripState {
  final List<GetTripModel> trips;
  final int currentIndex;

    final Map<int, TripSelections> selections; // ✅ هنا الجديد

  const TripLoaded(this.trips, this.currentIndex, {this.selections = const {}});


  TripLoaded copyWith({
    List<GetTripModel>? trips,
    int? currentIndex,
    Map<int, TripSelections>? selections,
  }) {
    return TripLoaded(
      trips ?? this.trips,
      currentIndex ?? this.currentIndex,
      selections: selections ?? this.selections,
    );
  }

  @override
  List<Object?> get props => [trips, currentIndex, selections];
}

class TripError extends TripState {
  final String message;
  const TripError(this.message);
  @override
  List<Object?> get props => [message];
}
