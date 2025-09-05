import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class DateCardStandalone extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialRangeStart;
  final DateTime? initialRangeEnd;

  const DateCardStandalone({
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
  State<DateCardStandalone> createState() => _DateCardStandaloneState();
}

class _DateCardStandaloneState extends State<DateCardStandalone> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  final CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    // ✅ بدل lastDate بـ DateTime.now()
    _focusedDay = widget.initialRangeEnd ?? DateTime.now();
    _rangeStart = widget.initialRangeStart;
    _rangeEnd = widget.initialRangeEnd;

    _focusedDay = _clampDate(_focusedDay);
    _rangeStart = _rangeStart != null ? _clampDate(_rangeStart!) : null;
    _rangeEnd = _rangeEnd != null ? _clampDate(_rangeEnd!) : null;
  }

  DateTime _clampDate(DateTime date) {
    if (date.isBefore(widget.firstDate)) return widget.firstDate;
    if (date.isAfter(widget.lastDate)) return widget.lastDate;
    return date;
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
            const SizedBox(height: 12),
            TableCalendar(
              firstDay: widget.firstDate,
              lastDay: widget.lastDate,
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              rangeSelectionMode: RangeSelectionMode.toggledOn,
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,

              onRangeSelected: (start, end, focusedDay) {
                setState(() {
                  _rangeStart = start;
                  _rangeEnd = end;
                  _focusedDay = focusedDay;
                });
                debugPrint("Start: $start | End: $end");
              },

              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Color.fromARGB(255, 3, 3, 174),
                  shape: BoxShape.circle,
                ),
                rangeStartDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                rangeEndDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                withinRangeDecoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  shape: BoxShape.rectangle,
                ),
              ),
            ),

            const SizedBox(height: 16),
            if (isSelectionValid) ...[
              Text(
                "You chose from ${_formatDate(_rangeStart!)}",
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 4),
              Text(
                "You chose to ${_formatDate(_rangeEnd!)}",
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context, null),
                  child: const Text("Cancel"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed:
                      isSelectionValid
                          ? () {
                            Navigator.pop(context, {
                              'range_start': _rangeStart,
                              'range_end': _rangeEnd,
                            });
                          }
                          : null,
                  child: const Text("Ok"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
