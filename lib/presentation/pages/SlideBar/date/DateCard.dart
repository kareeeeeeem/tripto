import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tripto/bloc&repo/date/date_bloc.dart';
import 'package:tripto/bloc&repo/date/date_event.dart';
import 'package:tripto/bloc&repo/date/date_state.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:table_calendar/table_calendar.dart';

class DateCard extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialRangeStart;
  final DateTime? initialRangeEnd;

  const DateCard({
    super.key,
    required this.firstDate,
    required this.lastDate,
    this.initialRangeStart,
    this.initialRangeEnd,
  });

  DateTime getLastDatePlusOneDay() {
    return lastDate.add(const Duration(days: 1));
  }

  @override
  State<DateCard> createState() => _DateCardState();
}

class _DateCardState extends State<DateCard> {
  late DateTime _focusedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.initialRangeEnd ?? widget.lastDate;
    _focusedDay = _clampDate(_focusedDay);
    _rangeStart = widget.initialRangeStart != null ? _clampDate(widget.initialRangeStart!) : null;
    _rangeEnd = widget.initialRangeEnd != null ? _clampDate(widget.initialRangeEnd!) : null;
  
  
  
  }

  DateTime _clampDate(DateTime date) {
    if (date.isBefore(widget.firstDate)) return widget.firstDate;
    if (date.isAfter(widget.getLastDatePlusOneDay())) return widget.getLastDatePlusOneDay();
    return date;
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _rangeStart = start != null ? _clampDate(start) : null;
      _rangeEnd = end != null ? _clampDate(end) : null;
      _focusedDay = _clampDate(focusedDay);
    });
  }

  // يحول كل الأرقام داخل string لأرقام عربية
  String _arabicDigits(String input) {
    const english = ['0','1','2','3','4','5','6','7','8','9'];
    const arabic  = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩'];
    for (int i = 0; i < 10; i++) {
      input = input.replaceAll(english[i], arabic[i]);
    }
    return input;
  }

  // يستخدم لتنسيق التواريخ في النصوص (yyyy-MM-dd) مع تحويل للأرقام لو اللغة عربية
  String _formatDateForText(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context).languageCode;
    final formatted = DateFormat('yyyy-MM-dd', locale).format(date);
    return locale == 'ar' ? _arabicDigits(formatted) : formatted;
  }

  // يرجع نص اليوم داخل المربع (يومي) مع تحويل للأرقام لو لازم
  String _dayNumberText(BuildContext context, DateTime day) {
    final locale = Localizations.localeOf(context).languageCode;
    final dayNum = day.day.toString();
    return locale == 'ar' ? _arabicDigits(dayNum) : dayNum;
  }

  @override
  Widget build(BuildContext context) {
    final bool isSelectionValid = _rangeStart != null && _rangeEnd != null;
    final loc = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final isArabic = locale == 'ar';

    return BlocListener<DateSelectionBloc, DateSelectionState>(
      listener: (context, state) {
        if (state is DateSelectionSuccess) {
          Navigator.pop(context, {
            'range_start': state.rangeStart,
            'range_end': state.rangeEnd,
          });
        }
      },
      child: AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // النصوص فوق الكاليندر
              Column(
                children: [
                  Text(
                    loc.tripAvailableFrom(_formatDateForText(context, widget.firstDate)),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    loc.tripAvailableTo(_formatDateForText(context, widget.lastDate)),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // الكاليندر — مع CalendarBuilders لتعريب أرقام الأيام والـ header & dow
              TableCalendar(
                key: ValueKey('${widget.firstDate}-${widget.getLastDatePlusOneDay()}'),
                firstDay: widget.firstDate,
                lastDay: widget.getLastDatePlusOneDay(),
                focusedDay: _focusedDay,
                rangeStartDay: _rangeStart,
                rangeEndDay: _rangeEnd,
                rangeSelectionMode: RangeSelectionMode.toggledOn,
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) => setState(() => _calendarFormat = format),
                onRangeSelected: _onRangeSelected,
                enabledDayPredicate: (day) =>
                    !day.isBefore(widget.firstDate) && !day.isAfter(widget.getLastDatePlusOneDay()),
                calendarStyle: CalendarStyle(
                  disabledTextStyle: const TextStyle(color: Colors.grey),
                  outsideTextStyle: const TextStyle(color: Colors.grey),
                  outsideDaysVisible: true,
                  todayDecoration: const BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                  rangeStartDecoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  rangeEndDecoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  withinRangeDecoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    shape: BoxShape.rectangle,
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  // تحويل نص الهيدر (شهر وسنة) للأرقام العربية لو لزم
                  titleTextFormatter: (date, locStr) {
                    final formatted = DateFormat.yMMMM(locale).format(date);
                    return isArabic ? _arabicDigits(formatted) : formatted;
                  },
                ),
                sixWeekMonthsEnforced: true,
                rowHeight: 40,
                locale: locale, // حافظ على locale من السياق

                // هنا نستخدم CalendarBuilders لنرسم أرقام الأيام بنفسنا
                calendarBuilders: CalendarBuilders(
                  // أيام الشهر العادية
                  defaultBuilder: (context, day, focusedDay) {
                    final txt = _dayNumberText(context, day);
                    return Center(
                      child: Text(txt, style: const TextStyle(fontWeight: FontWeight.bold)),
                    );
                  },

                  // اليوم الحالي
                  todayBuilder: (context, day, focusedDay) {
                    final txt = _dayNumberText(context, day);
                    return Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(txt, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    );
                  },

                  // اليوم/الأيام المختارة (start/end)
                  selectedBuilder: (context, day, focusedDay) {
                    final txt = _dayNumberText(context, day);
                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(txt, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    );
                  },

                  // أيام خارج الشهر
                  outsideBuilder: (context, day, focusedDay) {
                    final txt = _dayNumberText(context, day);
                    return Center(
                      child: Text(txt, style: const TextStyle(color: Colors.grey)),
                    );
                  },

                  // أيام معطلة
                  disabledBuilder: (context, day, focusedDay) {
                    final txt = _dayNumberText(context, day);
                    return Center(
                      child: Text(txt, style: const TextStyle(color: Colors.grey)),
                    );
                  },
                  rangeStartBuilder: (context, day, focusedDay) {
                    
  final txt = _dayNumberText(context, day); // استخدم نفس الدالة
  return Center(
    child: Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
      padding: const EdgeInsets.all(8),
      child: Text(txt, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    ),
  );
},

rangeEndBuilder: (context, day, focusedDay) {
  final txt = _dayNumberText(context, day); // هنا أيضًا
  return Center(
    child: Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
      padding: const EdgeInsets.all(8),
      child: Text(txt, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    ),
  );
},

withinRangeBuilder: (context, day, focusedDay) {
  final txt = _dayNumberText(context, day); // هنا كذلك
  return Center(
    child: Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.2), shape: BoxShape.rectangle),
      padding: const EdgeInsets.all(8),
      child: Text(txt, style: const TextStyle(fontWeight: FontWeight.bold)),
    ),
  );
},


                  // dowBuilder => يرسم رؤوس أيام الأسبوع (Sat, Sun...) — نستخدم التاريخ الممرَّر
                  dowBuilder: (context, day) {
                    // day هنا يمثل يوم داخل الأسبوع (من 1 إلى 7)، نستخدم تنسيق مختصر
                    final shortName = DateFormat.E(locale).format(day);
                    return Center(
                      child: Text(
                        shortName,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // بعد الاختيار
              if (isSelectionValid) ...[
                Text(
                  loc.youChoseFrom(_formatDateForText(context, _rangeStart!)),
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Text(
                  loc.youChoseTo(_formatDateForText(context, _rangeEnd!)),
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],

              // الأزرار
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: Text(loc.cancel)),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: isSelectionValid
                        ? () {
                            if (_rangeStart != null && _rangeEnd != null) {
                              context.read<DateSelectionBloc>().add(DateRangeSelected(_rangeStart!, _rangeEnd!));
                            }
                          }
                        : null,
                    child: Text(loc.ok),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
