abstract class CategoryTripEvent {}

class FetchTripsByCategoryEvent extends CategoryTripEvent {
  final String category;
  FetchTripsByCategoryEvent(this.category);
}
