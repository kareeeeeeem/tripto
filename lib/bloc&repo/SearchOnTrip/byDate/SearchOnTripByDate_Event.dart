import 'package:equatable/equatable.dart';

abstract class SearchTripByDateEvent extends Equatable {
  const SearchTripByDateEvent();

  @override
  List<Object> get props => [];
}

class FetchTripsByDate extends SearchTripByDateEvent {
  final DateTime from;
  final DateTime to;

  const FetchTripsByDate({required this.from, required this.to});

  @override
  List<Object> get props => [from, to];
}