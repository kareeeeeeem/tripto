import 'package:equatable/equatable.dart';

abstract class HotelsSearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchHotelsByName extends HotelsSearchEvent {
  final String query;
  final int subDestinationId;

  SearchHotelsByName({required this.query, required this.subDestinationId});

  @override
  List<Object?> get props => [query, subDestinationId];
}
