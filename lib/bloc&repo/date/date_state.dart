abstract class DateSelectionState {}

class DateSelectionInitial extends DateSelectionState {}

class DateSelectionSuccess extends DateSelectionState {
  final DateTime rangeStart;
  final DateTime rangeEnd;
  DateSelectionSuccess(this.rangeStart, this.rangeEnd);
}

class DateSelectionFailure extends DateSelectionState {
  final String error;
  DateSelectionFailure(this.error);
}
