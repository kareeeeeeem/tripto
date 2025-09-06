import 'package:equatable/equatable.dart';

abstract class SearchTripByCategoryEvent extends Equatable {
  const SearchTripByCategoryEvent();

  @override
  List<Object?> get props => [];
}

class FetchTripsByCategory extends SearchTripByCategoryEvent {
  final int category;

  const FetchTripsByCategory({required this.category});

  @override
  List<Object?> get props => [category];
}
