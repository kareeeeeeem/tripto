import 'package:flutter_bloc/flutter_bloc.dart';
import 'date_event.dart';
import 'date_state.dart';

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
        emit(DateSelectionSuccess(event.rangeStart, event.rangeEnd));
      } catch (e) {
        emit(DateSelectionFailure("حدث خطأ في اختيار التاريخ"));
      }
    });
  }
}
