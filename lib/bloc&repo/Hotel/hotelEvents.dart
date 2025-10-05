import 'package:equatable/equatable.dart';

abstract class HotelsEvent extends Equatable {
  const HotelsEvent();

  @override
  List<Object?> get props => [];
}

class FetchHotels extends HotelsEvent {
  final int subDestinationId;

  const FetchHotels({required this.subDestinationId});

  @override
  List<Object?> get props => [subDestinationId];
}

class FetchAllHotels extends HotelsEvent {
  const FetchAllHotels();

  @override
  List<Object?> get props => [];
}
