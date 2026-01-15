import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:tripto/l10n/app_localizations.dart';

class ArabicDateRangePicker extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;

  const ArabicDateRangePicker({
    super.key,
    required this.firstDate,
    required this.lastDate,
  });

  @override
  State<ArabicDateRangePicker> createState() => _ArabicDateRangePickerState();
}

class _ArabicDateRangePickerState extends State<ArabicDateRangePicker> {
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  
  

  String _arabicDigits(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    for (int i = 0; i < 10; i++) {
      input = input.replaceAll(english[i], arabic[i]);
    }
    return input;
  }

  String _formatDate(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context).languageCode;
    String formatted = DateFormat('yyyy-MM-dd', locale).format(date);

    if (locale == 'ar') {
      return _arabicDigits(formatted);
    }
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final loc = AppLocalizations.of(context)!;


    return AlertDialog(
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TableCalendar(
                locale: locale,
                firstDay: widget.firstDate,
                lastDay: widget.lastDate,
                focusedDay: _rangeStart ?? DateTime.now(),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextFormatter: (date, locale) {
                    final formatted = DateFormat.yMMMM(locale).format(date);
                    return locale == 'ar' ? _arabicDigits(formatted) : formatted;
                  },
                ),
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                selectedDayPredicate: (day) {
                  if (_rangeStart != null && _rangeEnd != null) {
                    return day.isAfter(_rangeStart!.subtract(const Duration(days: 1))) &&
                        day.isBefore(_rangeEnd!.add(const Duration(days: 1)));
                  }
                  if (_rangeStart != null && _rangeEnd == null) {
                    return isSameDay(day, _rangeStart);
                  }
                  return false;
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    if (_rangeStart == null || (_rangeStart != null && _rangeEnd != null)) {
                      _rangeStart = selectedDay;
                      _rangeEnd = null;
                    } else if (_rangeStart != null && _rangeEnd == null) {
                      if (selectedDay.isBefore(_rangeStart!)) {
                        _rangeEnd = _rangeStart;
                        _rangeStart = selectedDay;
                      } else {
                        _rangeEnd = selectedDay;
                      }
                    }
                  });
                },
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    final text =
                        locale == 'ar' ? _arabicDigits(day.day.toString()) : day.day.toString();
                    return Center(
                      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
                    );
                  },
                  todayBuilder: (context, day, focusedDay) {
                    final text =
                        locale == 'ar' ? _arabicDigits(day.day.toString()) : day.day.toString();
                    return Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          text,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                  selectedBuilder: (context, day, focusedDay) {
                    final text =
                        locale == 'ar' ? _arabicDigits(day.day.toString()) : day.day.toString();
                    return Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          text,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                  outsideBuilder: (context, day, focusedDay) {
                    final text =
                        locale == 'ar' ? _arabicDigits(day.day.toString()) : day.day.toString();
                    return Center(
                      child: Text(
                        text,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    );
                  },
                  disabledBuilder: (context, day, focusedDay) {
                    final text =
                        locale == 'ar' ? _arabicDigits(day.day.toString()) : day.day.toString();
                    return Center(
                      child: Text(
                        text,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
        
              
        
        
              const SizedBox(height: 16),
              if (_rangeStart != null && _rangeEnd != null)
                Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.youChoseFrom(
                        _formatDate(context, _rangeStart!),
                      ),
                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppLocalizations.of(context)!.youChoseTo(
                        _formatDate(context, _rangeEnd!),
                      ),
                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, null),
                    child: Text(loc.cancel),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: (_rangeStart != null && _rangeEnd != null)
                        ? () {
                            Navigator.pop(context, {
                              'range_start': _rangeStart!,
                              'range_end': _rangeEnd!,
                            });
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
