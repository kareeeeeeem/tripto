import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:tripto/bloc&repo/date/date_bloc.dart';
import 'package:tripto/bloc&repo/date/date_event.dart';
import 'package:tripto/bloc&repo/date/date_state.dart';
import 'package:tripto/l10n/app_localizations.dart';

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
    _rangeStart = null;
    _rangeEnd = null;

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
    final loc = AppLocalizations.of(context)!;

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
              Column(
                children: [
                  Text(
                    AppLocalizations.of(
                      context,
                    )!.tripAvailableFrom(_formatDate(widget.firstDate)),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppLocalizations.of(
                      context,
                    )!.tripAvailableTo(_formatDate(widget.lastDate)),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              const SizedBox(height: 12),
              TableCalendar(
                key: ValueKey(
                  '${widget.firstDate}-${widget.getLastDatePlusOneDay()}',
                ),
                firstDay: widget.firstDate,
                lastDay: widget.getLastDatePlusOneDay(),
                focusedDay: _focusedDay,
                rangeStartDay: _rangeStart,
                rangeEndDay: _rangeEnd,
                rangeSelectionMode: RangeSelectionMode.toggledOn,
                calendarFormat: _calendarFormat,
                onFormatChanged:
                    (format) => setState(() => _calendarFormat = format),
                onRangeSelected: _onRangeSelected,
                enabledDayPredicate:
                    (day) =>
                        !day.isBefore(widget.firstDate) &&
                        !day.isAfter(widget.getLastDatePlusOneDay()),
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

                locale: Localizations.localeOf(context).languageCode,
              ),
              const SizedBox(height: 16),

              // بعد ما يختار
              if (isSelectionValid) ...[
                Text(
                  AppLocalizations.of(
                    context,
                  )!.youChoseFrom(_formatDate(_rangeStart!)),
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(
                    context,
                  )!.youChoseTo(_formatDate(_rangeEnd!)),
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(loc.cancel),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed:
                        isSelectionValid
                            ? () {
                              if (_rangeStart != null && _rangeEnd != null) {
                                context.read<DateSelectionBloc>().add(
                                  DateRangeSelected(_rangeStart!, _rangeEnd!),
                                );
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
