import 'package:equatable/equatable.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_model.dart';

abstract class SearchTripByCategoryState extends Equatable {
  const SearchTripByCategoryState();

  @override
  List<Object?> get props => [];
}

class SearchTripByCategoryInitial extends SearchTripByCategoryState {}

class SearchTripByCategoryLoading extends SearchTripByCategoryState {}

class SearchTripByCategoryLoaded extends SearchTripByCategoryState {
  final List<GetTripModel> trips;
  const SearchTripByCategoryLoaded({required this.trips});
  @override List<Object?> get props => [trips];
}

// bloc already passes repository result => OK


class SearchTripByCategoryError extends SearchTripByCategoryState {
  final String message;

  const SearchTripByCategoryError({required this.message});

  @override
  List<Object?> get props => [message];
}
