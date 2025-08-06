import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class DateCard extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialSelectedDate;
  final bool allowRangeSelection;

  const DateCard({
    super.key,
    required this.firstDate,
    required this.lastDate,
    this.initialSelectedDate,
    this.allowRangeSelection = true,
  });

  @override
  State<DateCard> createState() => _DateCardState();
}

class _DateCardState extends State<DateCard> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  late RangeSelectionMode _rangeSelectionMode;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.initialSelectedDate ?? widget.firstDate;
    _selectedDay = widget.initialSelectedDate;
    _rangeSelectionMode =
        widget.allowRangeSelection
            ? RangeSelectionMode.toggledOff
            : RangeSelectionMode.disabled;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isWithinRange(selectedDay)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("التاريخ المحدد خارج نطاق الرحلة")),
      );
      return;
    }

    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _rangeStart = null;
      _rangeEnd = null;
      _rangeSelectionMode = RangeSelectionMode.toggledOff;
    });
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    if (!widget.allowRangeSelection) return;

    if (start == null ||
        end == null ||
        !isWithinRange(start) ||
        !isWithinRange(end)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("النطاق المحدد خارج نطاق الرحلة")),
      );
      return;
    }

    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });
  }

  bool isWithinRange(DateTime day) {
    return !day.isBefore(widget.firstDate) && !day.isAfter(widget.lastDate);
  }

  void _toggleRangeSelection() {
    setState(() {
      if (_rangeSelectionMode == RangeSelectionMode.toggledOff) {
        _rangeSelectionMode = RangeSelectionMode.toggledOn;
        _selectedDay = null;
      } else {
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
        _rangeStart = null;
        _rangeEnd = null;
      }
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
            const Text(
              "Choose Date",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),

            // زر التبديل بين اختيار يوم واحد أو فترة
            if (widget.allowRangeSelection)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _rangeSelectionMode == RangeSelectionMode.toggledOff
                          ? "Choose one day"
                          : " Choose a period",
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.swap_horiz),
                      onPressed: _toggleRangeSelection,
                    ),
                  ],
                ),
              ),

            TableCalendar(
              firstDay: widget.firstDate,
              lastDay: widget.lastDate,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              rangeSelectionMode: _rangeSelectionMode,
              calendarFormat: _calendarFormat,
              onFormatChanged:
                  (format) => setState(() => _calendarFormat = format),
              onDaySelected: _onDaySelected,
              onRangeSelected:
                  widget.allowRangeSelection ? _onRangeSelected : null,
              enabledDayPredicate: isWithinRange,
              calendarStyle: const CalendarStyle(
                isTodayHighlighted: true,
                rangeHighlightColor: Colors.blueAccent,
                selectedDecoration: BoxDecoration(
                  color: Colors.orange,
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
                outsideDaysVisible: false,
                disabledTextStyle: TextStyle(color: Colors.grey),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              locale: 'en',
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_selectedDay != null) {
                      Navigator.pop(context, _selectedDay);
                    } else if (_rangeStart != null && _rangeEnd != null) {
                      Navigator.pop(context, {
                        'range_start': _rangeStart!,
                        'range_end': _rangeEnd!,
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select a date or period"),
                        ),
                      );
                    }
                  },
                  child: const Text("ok"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
