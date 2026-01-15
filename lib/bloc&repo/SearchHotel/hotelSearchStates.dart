import 'package:equatable/equatable.dart';
import 'package:tripto/core/models/Hotels%D9%80model.dart';

abstract class HotelsSearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HotelsSearchInitial extends HotelsSearchState {}

class HotelsSearchLoading extends HotelsSearchState {}

class HotelsSearchLoaded extends HotelsSearchState {
  final List<HotelModel> hotels;

  HotelsSearchLoaded({required this.hotels});

  @override
  List<Object?> get props => [hotels];
}

class HotelsSearchError extends HotelsSearchState {
  final String message;

  HotelsSearchError({required this.message});

  @override
  List<Object?> get props => [message];
}
