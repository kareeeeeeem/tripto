import 'package:equatable/equatable.dart';

abstract class SearchTripByCategoryEvent extends Equatable {
  const SearchTripByCategoryEvent();

  @override
  List<Object?> get props => [];
}

// 1. ✅ الكلاس المفقود الذي تحتاجه (FetchAllTrips)
class FetchAllTrips extends SearchTripByCategoryEvent {
  const FetchAllTrips();
  
  @override
  List<Object?> get props => [];
}

// 2. الكلاس الموجود لديك مسبقاً
class FetchTripsByCategory extends SearchTripByCategoryEvent {
  final int category;

  const FetchTripsByCategory({required this.category});

  @override
  List<Object?> get props => [category];
}