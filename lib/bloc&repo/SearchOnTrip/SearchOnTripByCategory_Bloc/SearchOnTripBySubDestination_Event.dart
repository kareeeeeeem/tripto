import 'package:equatable/equatable.dart';

abstract class SearchSubDestinationEvent extends Equatable {
  const SearchSubDestinationEvent();

  @override
  List<Object?> get props => [];
}

class SearchSubDestinationRequested extends SearchSubDestinationEvent {
  final String query;

  const SearchSubDestinationRequested(this.query);

  @override
  List<Object?> get props => [query];
}
