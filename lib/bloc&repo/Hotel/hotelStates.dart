import 'package:equatable/equatable.dart';
import '../../../core/models/Hotelsـmodel.dart';

abstract class HotelsState extends Equatable {
  const HotelsState();

  @override
  List<Object?> get props => [];
}

class HotelsInitial extends HotelsState {}

class HotelsLoading extends HotelsState {}

class HotelsLoaded extends HotelsState {
  final List<HotelModel> hotels;

  const HotelsLoaded({required this.hotels});

  @override
  List<Object?> get props => [hotels];
}

class HotelsError extends HotelsState {
  final String message;

  const HotelsError({required this.message});

  @override
  List<Object?> get props => [message];
}
