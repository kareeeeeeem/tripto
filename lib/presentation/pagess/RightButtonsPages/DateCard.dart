import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // لا تنسى استيراد table_calendar

class Datecard extends StatefulWidget {
  const Datecard({super.key});

  @override
  State<Datecard> createState() => _DatecardState();
}

class _DatecardState extends State<Datecard> {
  // تعريف متغير لحفظ اليوم الذي يركز عليه التقويم
  DateTime _focusedDay = DateTime.now();
  // تعريف متغير لحفظ اليوم الذي يختاره المستخدم، ويجب أن يكون nullable في البداية
  DateTime? _selectedDay; // <-- تم التعديل هنا: يجب أن يكون nullable

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // الشكل والحواف المستديرة لمربع الحوار
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      // هنا يجب أن يكون محتوى الـ Dialog وليس child للـ shape
      child: Padding(
        // <-- أضفنا Padding ليعطي مساحة حول التقويم والأزرار
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // لجعل العمود يأخذ أقل مساحة ممكنة عموديا
          children: [
            TableCalendar(
              // <-- تم التصحيح هنا: كان مكتوب TabelCalender
              // تواريخ البداية والنهاية التي يمكن للمستخدم الاختيار منها
              firstDay: DateTime.utc(
                2010,
                10,
                16,
              ), // <-- تم التصحيح هنا: كان مكتوب firstday
              lastDay: DateTime.utc(
                2030,
                3,
                14,
              ), // <-- تم التصحيح هنا: كان مكتوب lastday
              // اليوم الذي يظهر التقويم مركزًا عليه
              focusedDay: _focusedDay,

              // هذه الخاصية تحدد اليوم الذي يتم "تحديده" أو "تمييزه" في التقويم
              // تعود بقيمة true إذا كان اليوم الحالي هو _selectedDay
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },

              // الدالة التي يتم استدعاؤها عند اختيار المستخدم ليوم جديد
              onDaySelected: (selectedDay, focusedDay) {
                // نتحقق إذا كان اليوم المختار مختلفًا عن اليوم الحالي لنتجنب تحديث الحالة بدون داعي
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay; // نحدث اليوم المختار
                    _focusedDay = focusedDay; // نحدث اليوم المركز
                  });
                }
              },

              // تخصيص رأس التقويم (الشهر والسنة)
              headerStyle: const HeaderStyle(
                formatButtonVisible:
                    false, // إخفاء زر تغيير العرض (شهر، أسبوع، أسبوعين)
                titleCentered: true, // توسيط عنوان الشهر والسنة
              ),
              // تخصيص شكل الأيام في التقويم
              calendarStyle: CalendarStyle(
                selectedDecoration: const BoxDecoration(
                  color: Colors.blue, // لون تظليل اليوم المختار
                  shape: BoxShape.circle, // شكل دائرة لليوم المختار
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5), // لون اليوم الحالي
                  shape: BoxShape.circle,
                ),
                // يمكنك إضافة المزيد من التخصيصات هنا
              ),
            ),
            const SizedBox(height: 20), // مسافة فاصلة
            // زر التأكيد لإغلاق مربع الحوار وإرجاع التاريخ المختار
            ElevatedButton(
              onPressed: () {
                // نغلق مربع الحوار ونمرر التاريخ المختار
                // إذا لم يختار المستخدم أي تاريخ، ستكون القيمة null
                Navigator.of(context).pop(_selectedDay);
              },
              child: const Text('ok'),
            ),
          ],
        ),
      ),
    );
  }
}
