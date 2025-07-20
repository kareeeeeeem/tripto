import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tripto/core/models/Hotels_details_model.dart';

import '../../../l10n/app_localizations.dart';

class Datecard extends StatefulWidget {
  const Datecard({super.key});

  @override
  State<Datecard> createState() => _DatecardState();
}

class _DatecardState extends State<Datecard> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;

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
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              rangeSelectionMode: _rangeSelectionMode,
              selectedDayPredicate: (day) => false,
              onRangeSelected: (start, end, focusedDay) {
                setState(() {
                  _rangeStart = start;
                  _rangeEnd = end;
                  _focusedDay = focusedDay;
                  _rangeSelectionMode = RangeSelectionMode.toggledOn;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_rangeStart, selectedDay)) {
                  setState(() {
                    _rangeStart = selectedDay;
                    _rangeEnd = null;
                    _focusedDay = focusedDay;
                    _rangeSelectionMode = RangeSelectionMode.toggledOn;
                  });
                }
              },
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: CalendarStyle(
                rangeHighlightColor: Colors.lightBlueAccent,
                rangeStartDecoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                rangeEndDecoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                withinRangeDecoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
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

            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.055, // تقريبًا 45 من ارتفاع شاشة 800

              child: ElevatedButton(
                onPressed: () {
                  if (_rangeStart != null && _rangeEnd != null) {
                    Navigator.pop(context);
                    openbottomsheetforhotel(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF002E70), // ✅ اللون الهادي
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // padding: EdgeInsets.symmetric(
                  //   horizontal: MediaQuery.of(context).size.width * 0.06, // تقريبًا بدل 24
                  //   vertical: MediaQuery.of(context).size.height * 0.017, // تقريبًا بدل 14
                  // ),

                  elevation: 0,
                ),
                child:  Text(
                  AppLocalizations.of(context)!.selectahotel,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
