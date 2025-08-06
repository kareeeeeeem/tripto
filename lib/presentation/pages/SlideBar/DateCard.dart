import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

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

    _focusedDay = widget.initialRangeStart ?? DateTime.now();
    _rangeStart = widget.initialRangeStart;
    _rangeEnd = widget.initialRangeEnd;

    // تأكيد أن التواريخ ضمن النطاق المحدد
    _focusedDay = _clampDate(_focusedDay);
    _rangeStart = _rangeStart != null ? _clampDate(_rangeStart!) : null;
    _rangeEnd = _rangeEnd != null ? _clampDate(_rangeEnd!) : null;
  }

  DateTime _clampDate(DateTime date) {
    if (date.isBefore(widget.firstDate)) return widget.firstDate;
    if (date.isAfter(widget.lastDate)) return widget.lastDate;
    return date;
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _rangeStart = start != null ? _clampDate(start) : null;
      _rangeEnd = end != null ? _clampDate(end) : null;
      _focusedDay = _clampDate(focusedDay);
    });
  }

  String _formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  @override
  Widget build(BuildContext context) {
    final bool isSelectionValid = _rangeStart != null && _rangeEnd != null;

    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// العنوان مع التاريخ المتاح
            Text(
              "اختر الفترة من ${_formatDate(widget.firstDate)} إلى ${_formatDate(widget.lastDate)}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            /// تقويم الاختيار
            TableCalendar(
              key: ValueKey('${widget.firstDate}-${widget.lastDate}'),
              firstDay: widget.firstDate,
              lastDay: widget.lastDate,
              focusedDay: _focusedDay,
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              rangeSelectionMode: RangeSelectionMode.toggledOn,
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() => _calendarFormat = format);
              },
              onRangeSelected: _onRangeSelected,
              enabledDayPredicate:
                  (day) =>
                      !day.isBefore(widget.firstDate) &&
                      !day.isAfter(widget.lastDate),
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
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              sixWeekMonthsEnforced: true,
              rowHeight: 40,
            ),

            const SizedBox(height: 16),

            /// عرض التواريخ المختارة إن وجدت
            if (isSelectionValid)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "الفترة المختارة: ${_formatDate(_rangeStart!)} إلى ${_formatDate(_rangeEnd!)}",
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),

            /// أزرار الإجراءات
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("إلغاء"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed:
                      isSelectionValid
                          ? () {
                            Navigator.pop(context, {
                              'range_start': _rangeStart!,
                              'range_end': _rangeEnd!,
                            });
                          }
                          : null,
                  child: const Text("تأكيد"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
