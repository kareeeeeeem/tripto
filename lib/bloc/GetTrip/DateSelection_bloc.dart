import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DateSelectionEvent {}

class DateRangeSelected extends DateSelectionEvent {
  final DateTime rangeStart;
  final DateTime rangeEnd;

  DateRangeSelected(this.rangeStart, this.rangeEnd);
}

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

class DateSelectionBloc extends Bloc<DateSelectionEvent, DateSelectionState> {
  DateSelectionBloc() : super(DateSelectionInitial()) {
    on<DateRangeSelected>((event, emit) async {
      try {
        if (event.rangeStart.isAfter(event.rangeEnd)) {
          emit(
            DateSelectionFailure("تاريخ البداية يجب أن يكون قبل تاريخ النهاية"),
          );
          return;
        }

        await Future.delayed(const Duration(milliseconds: 300));
        emit(DateSelectionSuccess(event.rangeStart, event.rangeEnd));
      } catch (e) {
        emit(DateSelectionFailure("حدث خطأ في اختيار التاريخ"));
      }
    });
  }
}
