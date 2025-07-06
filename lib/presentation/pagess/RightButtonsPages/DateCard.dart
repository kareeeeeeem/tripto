import 'package:flutter/material.dart';

// تعريف typedef للدالة التي سيتم استدعاؤها عند اختيار تاريخ
typedef OnDateRangeSelected =
    void Function(DateTime? startDate, DateTime? endDate);

class CustomCalendar extends StatefulWidget {
  final DateTime? initialStartDate; // تاريخ البداية الأولي
  final DateTime? initialEndDate; // تاريخ النهاية الأولي
  final OnDateRangeSelected
  onDateRangeSelected; // الدالة التي سيتم استدعاؤها عند الاختيار

  const CustomCalendar({
    Key? key,
    this.initialStartDate,
    this.initialEndDate,
    required this.onDateRangeSelected,
  }) : super(key: key);

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  // لغرض عرض التقويم: مايو 2024 (كما في لقطة الشاشة)
  // يمكنك جعل هذه المتغيرات ديناميكية أكثر إذا أردت التنقل بين الشهور والأعوام
  final int _currentYear = 2024;
  final int _currentMonth = 5; // مايو

  final List<String> _weekDays = [
    'SUN',
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
  ];

  @override
  void initState() {
    super.initState();
    _selectedStartDate = widget.initialStartDate;
    _selectedEndDate = widget.initialEndDate;
  }

  // دالة مساعدة للحصول على عدد الأيام في الشهر
  int _daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  // دالة مساعدة للحصول على يوم الأسبوع لأول يوم في الشهر (0=الأحد، 6=السبت)
  int _firstDayOfMonthWeekday(int year, int month) {
    int dartWeekday =
        DateTime(year, month, 1).weekday; // 1=الإثنين, ..., 7=الأحد
    return (dartWeekday % 7); // تحويل 1-7 إلى 0-6 حيث الأحد (7) يصبح 0
  }

  // دالة لمعالجة اختيار التاريخ
  void _onDateSelected(int day) {
    DateTime selectedDate = DateTime(_currentYear, _currentMonth, day);

    setState(() {
      if (_selectedStartDate == null) {
        _selectedStartDate = selectedDate;
        _selectedEndDate = null;
      } else if (_selectedEndDate == null) {
        if (selectedDate.isAfter(_selectedStartDate!)) {
          _selectedEndDate = selectedDate;
        } else {
          _selectedStartDate = selectedDate;
          _selectedEndDate = null;
        }
      } else {
        _selectedStartDate = selectedDate;
        _selectedEndDate = null;
      }
      // استدعاء الدالة التي تم تمريرها لإبلاغ الـ parent widget بالاختيار
      widget.onDateRangeSelected(_selectedStartDate, _selectedEndDate);
    });
  }

  // دالة للتحقق مما إذا كان التاريخ ضمن النطاق المختار
  bool _isDateInRange(DateTime date) {
    if (_selectedStartDate == null) return false;
    if (_selectedEndDate == null) return date == _selectedStartDate;

    return (date.isAfter(_selectedStartDate!) || date == _selectedStartDate) &&
        (date.isBefore(_selectedEndDate!) || date == _selectedEndDate);
  }

  // دالة للتحقق مما إذا كان التاريخ هو تاريخ البداية
  bool _isStartDate(DateTime date) {
    return _selectedStartDate != null && date == _selectedStartDate;
  }

  // دالة للتحقق مما إذا كان التاريخ هو تاريخ النهاية
  bool _isEndDate(DateTime date) {
    return _selectedEndDate != null && date == _selectedEndDate;
  }

  @override
  Widget build(BuildContext context) {
    int daysInCurrentMonth = _daysInMonth(_currentYear, _currentMonth);
    int firstDayWeekday = _firstDayOfMonthWeekday(_currentYear, _currentMonth);

    int totalGridCells = 7 * 6; // 6 صفوف كافية لأي شهر

    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // تصفح الشهر (أيقونات السهم والشهر)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_left, color: Colors.blue),
                  onPressed: () {
                    // TODO: إضافة منطق للانتقال للشهر السابق
                  },
                ),
                Text(
                  'May 2024', // يمكن جعل هذا ديناميكياً
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_right, color: Colors.blue),
                  onPressed: () {
                    // TODO: إضافة منطق للانتقال للشهر التالي
                  },
                ),
              ],
            ),
            SizedBox(height: 16),

            // رؤوس أيام الأسبوع
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.0,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: _weekDays.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    _weekDays[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 8),

            // شبكة الأيام
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.0,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: totalGridCells,
              itemBuilder: (context, index) {
                final int dayNumber;
                final bool isCurrentMonthDay;
                final DateTime date;

                if (index < firstDayWeekday) {
                  int previousMonthLastDay = _daysInMonth(
                    _currentYear,
                    _currentMonth - 1,
                  );
                  dayNumber =
                      previousMonthLastDay - (firstDayWeekday - 1 - index);
                  isCurrentMonthDay = false;
                  date = DateTime(_currentYear, _currentMonth - 1, dayNumber);
                } else if (index >= firstDayWeekday + daysInCurrentMonth) {
                  dayNumber =
                      index - (firstDayWeekday + daysInCurrentMonth) + 1;
                  isCurrentMonthDay = false;
                  date = DateTime(_currentYear, _currentMonth + 1, dayNumber);
                } else {
                  dayNumber = index - firstDayWeekday + 1;
                  isCurrentMonthDay = true;
                  date = DateTime(_currentYear, _currentMonth, dayNumber);
                }

                Color backgroundColor = Colors.transparent;
                Color textColor =
                    isCurrentMonthDay ? Colors.black : Colors.grey;

                bool isSelected = _isDateInRange(date);
                bool isStart = _isStartDate(date);
                bool isEnd = _isEndDate(date);

                if (isStart || isEnd) {
                  backgroundColor = Colors.blue;
                  textColor = Colors.white;
                } else if (isSelected) {
                  backgroundColor = Colors.blue.withOpacity(0.2);
                  textColor = Colors.blue;
                }

                return GestureDetector(
                  onTap:
                      isCurrentMonthDay
                          ? () => _onDateSelected(dayNumber)
                          : null, // فقط أيام الشهر الحالي قابلة للنقر
                  child: Container(
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '$dayNumber',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
