abstract class SearchTripBySubDestinationEvent {}

class FetchTripsBySubDestination extends SearchTripBySubDestinationEvent {
  final String subDestination;

  FetchTripsBySubDestination({required this.subDestination});
}
