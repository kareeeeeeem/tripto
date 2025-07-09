import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // Don't forget to import table_calendar

class Datecard extends StatefulWidget {
  const Datecard({super.key});

  @override
  State<Datecard> createState() => _DatecardState();
}

class _DatecardState extends State<Datecard> {
  DateTime _focusedDay = DateTime.now();
  DateTime?
  _rangeStart; // New: Variable to store the start of the selected range
  DateTime? _rangeEnd; // New: Variable to store the end of the selected range
  RangeSelectionMode _rangeSelectionMode =
      RangeSelectionMode.toggledOn; // New: To manage range selection state

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              // New: Enable range selection
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              rangeSelectionMode: _rangeSelectionMode,

              // This property determines which days are highlighted as part of the range
              // We'll rely on the built-in range selection highlighting of table_calendar
              // You can still use selectedDayPredicate if you need custom single-day selection alongside range,
              // but for a trip range, the rangeStartDay and rangeEndDay are key.
              selectedDayPredicate: (day) {
                // We're not using this for single day selection anymore for trip booking
                // but if you want to highlight a specific day even within a range, you could add logic here.
                return false; // No single day selected highlighting by default for trip range
              },

              // New: Callback for when a day is selected in range mode
              onRangeSelected: (start, end, focusedDay) {
                setState(() {
                  _rangeStart = start;
                  _rangeEnd = end;
                  _focusedDay = focusedDay;
                  // Ensure range selection mode is active if a range is being selected
                  _rangeSelectionMode = RangeSelectionMode.toggledOn;
                });
              },

              // Existing: Callback for single day selection (can be used to initiate range)
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_rangeStart, selectedDay)) {
                  setState(() {
                    _rangeStart = selectedDay;
                    _rangeEnd =
                        null; // Reset end day when a new start day is selected
                    _focusedDay = focusedDay;
                    _rangeSelectionMode =
                        RangeSelectionMode.toggledOn; // Start range selection
                  });
                }
              },

              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: CalendarStyle(
                rangeHighlightColor:
                    Colors
                        .lightBlueAccent, // New: Color for the selected date range
                rangeStartDecoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                rangeEndDecoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                withinRangeDecoration: BoxDecoration(
                  color: Colors.blue.withOpacity(
                    0.3,
                  ), // Color for days within the range
                  shape: BoxShape.circle, // You can customize this
                ),
                selectedDecoration: const BoxDecoration(
                  // This is for single selected day, less relevant for trip range
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Pass back the selected start and end dates
                // You can return a Map, a custom Trip object, or just the two dates.
                // For simplicity, let's return a Map.
                Navigator.of(
                  context,
                ).pop({'startDate': _rangeStart, 'endDate': _rangeEnd});
              },
              child: const Text('Confirm Trip Dates'),
            ),
          ],
        ),
      ),
    );
  }
}
