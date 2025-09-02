abstract class DateSelectionEvent {}

class DateRangeSelected extends DateSelectionEvent {
  final DateTime rangeStart;
  final DateTime rangeEnd;
  DateRangeSelected(this.rangeStart, this.rangeEnd);
}
