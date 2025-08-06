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
    _focusedDay = widget.initialRangeStart ?? widget.firstDate;
    _rangeStart = widget.initialRangeStart;
    _rangeEnd = widget.initialRangeEnd;
  }

  bool _isValidRange(DateTime start, DateTime end) {
    // تحقق من أن الفترة ضمن النطاق المسموح
    final isStartValid =
        !start.isBefore(widget.firstDate) && !start.isAfter(widget.lastDate);
    final isEndValid =
        !end.isBefore(widget.firstDate) && !end.isAfter(widget.lastDate);

    return isStartValid && isEndValid && !start.isAfter(end);
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    if (start == null || end == null) return;

    if (!_isValidRange(start, end)) {
      final dateFormat = DateFormat('yyyy-MM-dd');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "يجب أن تكون الفترة بين ${dateFormat.format(widget.firstDate)} و ${dateFormat.format(widget.lastDate)}",
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    setState(() {
      _rangeStart = start;
      _rangeEnd = end;
      _focusedDay = focusedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            Text(
              "اختر فترة (${DateFormat('yyyy-MM-dd').format(widget.firstDate)} إلى ${DateFormat('yyyy-MM-dd').format(widget.lastDate)})",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            TableCalendar(
              firstDay: widget.firstDate,
              lastDay: widget.lastDate,
              focusedDay: _focusedDay,
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              rangeSelectionMode: RangeSelectionMode.toggledOn,
              calendarFormat: _calendarFormat,
              onFormatChanged:
                  (format) => setState(() => _calendarFormat = format),
              onRangeSelected: _onRangeSelected,
              enabledDayPredicate: (day) {
                return !day.isBefore(widget.firstDate) &&
                    !day.isAfter(widget.lastDate);
              },
              calendarStyle: CalendarStyle(
                disabledTextStyle: const TextStyle(color: Colors.grey),
                todayDecoration: BoxDecoration(
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
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("إلغاء"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_rangeStart == null || _rangeEnd == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("الرجاء اختيار فترة صالحة"),
                        ),
                      );
                      return;
                    }
                    Navigator.pop(context, {
                      'range_start': _rangeStart!,
                      'range_end': _rangeEnd!,
                    });
                  },
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
