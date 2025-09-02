import 'package:equatable/equatable.dart';

abstract class SearchSubDestinationState extends Equatable {
  const SearchSubDestinationState();

  @override
  List<Object?> get props => [];
}

class SearchSubDestinationInitial extends SearchSubDestinationState {}

class SearchSubDestinationLoading extends SearchSubDestinationState {}

class SearchSubDestinationLoaded extends SearchSubDestinationState {
  final List<dynamic> trips;

  const SearchSubDestinationLoaded(this.trips);

  @override
  List<Object?> get props => [trips];
}

class SearchSubDestinationError extends SearchSubDestinationState {
  final String message;

  const SearchSubDestinationError(this.message);

  @override
  List<Object?> get props => [message];
}
