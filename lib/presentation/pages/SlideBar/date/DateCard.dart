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
  final List<String> availableFromDates; // 🆕 لإدارة الفواصل الزمنية
  final List<String> availableToDates;   // 🆕 لإدارة الفواصل الزمنية

  final DateTime? initialRangeStart;
  final DateTime? initialRangeEnd;

  

  const DateCard({
    super.key,
    required this.firstDate,
    required this.lastDate,
    this.initialRangeStart,
    this.initialRangeEnd,
     required this.availableFromDates,
      required this.availableToDates,
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
    _focusedDay = widget.initialRangeEnd ?? widget.firstDate;
    _focusedDay = _clampDate(_focusedDay);
    _rangeStart = widget.initialRangeStart != null ? _clampDate(widget.initialRangeStart!) : null;
    _rangeEnd = widget.initialRangeEnd != null ? _clampDate(widget.initialRangeEnd!) : null;
  
  
  
  }

  DateTime _clampDate(DateTime date) {
    if (date.isBefore(widget.firstDate)) return widget.firstDate;
    if (date.isAfter(widget.getLastDatePlusOneDay())) return widget.getLastDatePlusOneDay();
    return date;
  }

  // داخل class _DateCardState
void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
  
  final clampedStart = start != null ? _clampDate(start) : null;
  final clampedEnd = end != null ? _clampDate(end) : null;

  // 1. التحقق من اكتمال النطاق (تاريخ بداية ونهاية محددين)
  if (clampedStart != null && clampedEnd != null) {
    // 2. التحقق من صحة النطاق: يجب أن يقع ضمن فترة واحدة متاحة
    if (_isRangeContainedInOnePeriod(clampedStart, clampedEnd)) {
      // ✅ النطاق صحيح، قم بتحديث الحالة
      setState(() {
        _rangeStart = clampedStart;
        _rangeEnd = clampedEnd;
        _focusedDay = _clampDate(focusedDay);
      });
    } else {
      // ❌ النطاق يمر بفترة مغلقة أو يمتد على فترتين، قم بإلغاء الاختيار
      setState(() {
        _rangeStart = null;
        _rangeEnd = null;
        _focusedDay = _clampDate(focusedDay);
      });
      // 🔔 (اختياري) يمكنك إضافة SnackBar هنا لتنبيه المستخدم
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.rangeNotContained)),
      );
    }
  } else {
    // حالة تحديد تاريخ واحد (البداية أو النهاية) فقط
    setState(() {
      _rangeStart = clampedStart;
      _rangeEnd = clampedEnd;
      _focusedDay = _clampDate(focusedDay);
    });
  }
}

// 🆕 دالة جديدة للتحقق من أن النطاق يقع ضمن فترة متاحة واحدة
bool _isRangeContainedInOnePeriod(DateTime start, DateTime end) {
  // يجب أن يكون تاريخ البداية قبل تاريخ النهاية
  if (start.isAfter(end)) return false; 
  
  // التكرار على جميع الفترات المتاحة للرحلة
  for (int i = 0; i < widget.availableFromDates.length; i++) {
    try {
      final periodStart = DateTime.parse(widget.availableFromDates[i]);
      final periodEnd = DateTime.parse(widget.availableToDates[i]);

      // نقوم بتجاهل الوقت (TimeOfDay) للتأكد من المقارنة باليوم
      final dayStart = DateTime(start.year, start.month, start.day);
      final dayEnd = DateTime(end.year, end.month, end.day);
      
      // هل تاريخ بداية النطاق >= تاريخ بداية الفترة المتاحة
      final isStartValid = dayStart.isAfter(periodStart.subtract(const Duration(days: 1))) || dayStart.isAtSameMomentAs(periodStart);
      
      // وهل تاريخ نهاية النطاق <= تاريخ نهاية الفترة المتاحة
      final isEndValid = dayEnd.isBefore(periodEnd.add(const Duration(days: 1))) || dayEnd.isAtSameMomentAs(periodEnd);

      // إذا كان النطاق بأكمله (البداية والنهاية) يقع ضمن هذه الفترة الواحدة
      if (isStartValid && isEndValid) {
        return true; // ✅ النطاق يقع بالكامل ضمن فترة واحدة
      }
    } catch (e) {
      continue;
    }
  }

  return false; // ❌ النطاق لا يقع بالكامل ضمن أي فترة متاحة واحدة
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
                _buildAvailabilityText(), // ✅ استخدام الدالة الجديدة
                style: const TextStyle(
                  color: Colors.brown,
                    fontWeight: FontWeight.bold, fontSize: 16), // قلل الحجم قليلاً إذا لزم
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // الكاليندر — مع CalendarBuilders لتعريب أرقام الأيام والـ header & dow
              TableCalendar(
                enabledDayPredicate: _isDayAvailable, 

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
                // enabledDayPredicate: (day) =>
                //     !day.isBefore(widget.firstDate) && !day.isAfter(widget.getLastDatePlusOneDay()),
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
        ],
      ),
     ),
    )
  );
    
  }
  // 🆕 دالة جديدة للتحقق من أن اليوم يقع ضمن أي فترة متاحة في القوائم
bool _isDayAvailable(DateTime day) {
  // التحقق من أن اليوم يقع ضمن النطاق الكلي (firstDate إلى lastDate)
  if (day.isBefore(widget.firstDate) || day.isAfter(widget.lastDate.add(const Duration(days: 1)))) {
    return false;
  }

  // التكرار على جميع الفترات المتاحة للرحلة
  for (int i = 0; i < widget.availableFromDates.length; i++) {
    try {
      final periodStart = DateTime.parse(widget.availableFromDates[i]);
      final periodEnd = DateTime.parse(widget.availableToDates[i]);

      // شرط التحقق من أن اليوم يقع بالضبط بين تاريخ البداية وتاريخ النهاية للفترة
      if (day.isAfter(periodStart.subtract(const Duration(days: 1))) &&
          day.isBefore(periodEnd.add(const Duration(days: 1)))) {
        return true; // إذا وقع اليوم ضمن فترة واحدة على الأقل، فهو متاح
      }
    } catch (e) {
      // تجاهل التاريخ غير الصالح والمتابعة للفترة التالية
      continue;
    }
  }

  return false; // إذا لم يقع اليوم ضمن أي فترة متاحة
}


// 🆕 دالة جديدة لإنشاء نص التوفر المتعدد الأسطر (بتطبيق الترجمة)
String _buildAvailabilityText() {
  final loc = AppLocalizations.of(context)!;
  final locale = Localizations.localeOf(context).languageCode;
  final isArabic = locale == 'ar';
  
  if (widget.availableFromDates.isEmpty) {
    return loc.tripNotAvailable; // استخدام نص عدم التوفر
  }

  final StringBuffer buffer = StringBuffer();
  
  buffer.writeln(loc.tripAvailablePeriods); // استخدام عنوان الفترات

  for (int i = 0; i < widget.availableFromDates.length; i++) {
    try {
      final start = DateTime.parse(widget.availableFromDates[i]);
      final end = DateTime.parse(widget.availableToDates[i]);
      
      final startFormatted = _formatDateForText(context, start);
      final endFormatted = _formatDateForText(context, end);

      // هنا نستخدم loc.from و loc.to إذا قمت بإضافتهما للملفات
      buffer.writeln(
        '• ${loc.from} $startFormatted ${loc.to} $endFormatted'
      );
      
    } catch (e) {
      continue;
    }
  }

  return buffer.toString().trim();
}
}
