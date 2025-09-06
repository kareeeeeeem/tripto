import 'package:equatable/equatable.dart';

abstract class SearchTripByCategoryState extends Equatable {
  const SearchTripByCategoryState();

  @override
  List<Object?> get props => [];
}

class SearchTripByCategoryInitial extends SearchTripByCategoryState {}

class SearchTripByCategoryLoading extends SearchTripByCategoryState {}

class SearchTripByCategoryLoaded extends SearchTripByCategoryState {
  final List<dynamic> trips;

  const SearchTripByCategoryLoaded({required this.trips});

  @override
  List<Object?> get props => [trips];
}

class SearchTripByCategoryError extends SearchTripByCategoryState {
  final String message;

  const SearchTripByCategoryError({required this.message});

  @override
  List<Object?> get props => [message];
}
