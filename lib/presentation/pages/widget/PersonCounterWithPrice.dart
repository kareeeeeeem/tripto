import 'package:flutter/material.dart';

class PersonCounterWithPrice extends StatefulWidget {
  final double
  basePricePerPerson; // السعر الأساسي للشخص الواحد (يمكن تحديده عند الاستخدام)
  final Color textColor; // لون النص (يمكن تحديده عند الاستخدام)
  final Color iconColor; // لون الأيقونات (يمكن تحديده عند الاستخدام)
  final Color backgroundColor; // لون خلفية العداد (يمكن تحديده عند الاستخدام)
  final int maxPersons; // <-- أضف هذا

  const PersonCounterWithPrice({
    super.key,
    this.basePricePerPerson = 0.0, // قيمة افتراضية
    this.textColor = Colors.white,
    this.iconColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.maxPersons = 30, // <-- قيمة افتراضية
  });

  @override
  // ignore: library_private_types_in_public_api
  _PersonCounterWithPriceState createState() => _PersonCounterWithPriceState();
}

class _PersonCounterWithPriceState extends State<PersonCounterWithPrice> {
  int _numberOfPeople = 1; // العدد الأولي للأشخاص
  double _totalPrice = 0.0; // السعر الإجمالي

  @override
  void initState() {
    super.initState();
    _updateTotalPrice(); // حساب السعر الإجمالي الأولي بناءً على العدد الأولي
  }

  void _incrementPeople() {
    setState(() {
      if (_numberOfPeople < widget.maxPersons) {
        _numberOfPeople++;
        _updateTotalPrice();
      }
    });
  }

  void _decrementPeople() {
    setState(() {
      if (_numberOfPeople > 1) {
        // منع النزول أقل من شخص واحد
        _numberOfPeople--;
        _updateTotalPrice();
      }
    });
  }

  void _updateTotalPrice() {
    _totalPrice = _numberOfPeople * widget.basePricePerPerson;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final double responsiveRadius =
        screenWidth * 0.035; // نصف قطر دائرة الأيقونات
    final double responsiveIconSize =
        screenWidth * 0.04; // حجم الأيقونات (الزائد والناقص والشخص)
    final double responsiveFontSize = screenWidth * 0.055; // حجم الخطوط

    return Container(
      // تحديد المسافة الأفقية كنسبة مئوية من عرض الشاشة
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03, // مسافة أفقية متجاوبة
        vertical: 15, // مسافة رأسية ثابتة
      ),
      decoration: BoxDecoration(
        color: widget.backgroundColor.withOpacity(0.0), // شفافية بسيطة للخلفية
        borderRadius: BorderRadius.circular(25), // حواف دائرية
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // الـ Row يأخذ حجم المحتوى فقط
        children: [
          // 1. زر الزيادة (+)
          GestureDetector(
            onTap: _incrementPeople,
            child: CircleAvatar(
              radius: responsiveRadius, // استخدام نصف قطر متجاوب
              backgroundColor: widget.backgroundColor.withOpacity(0.7),
              child: Icon(
                Icons.add,
                color: widget.iconColor,
                size: responsiveIconSize,
              ), // استخدام حجم أيقونة متجاوب
            ),
          ),

          const SizedBox(width: 10), // مسافة ثابتة
          // 2. عدد الأشخاص
          Text(
            '$_numberOfPeople',
            style: TextStyle(
              fontSize: responsiveFontSize, // استخدام حجم خط متجاوب
              fontWeight: FontWeight.bold,
              color: widget.textColor,
              shadows: [
                Shadow(
                  blurRadius: 3.0,
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(1.0, 1.0),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10), // مسافة ثابتة
          // 3. زر النقصان (-)
          GestureDetector(
            onTap: _decrementPeople,
            child: CircleAvatar(
              radius: responsiveRadius, // استخدام نصف قطر متجاوب
              backgroundColor: widget.backgroundColor.withOpacity(0.7),
              child: Icon(
                Icons.remove,
                color: widget.iconColor,
                size: responsiveIconSize,
              ), // استخدام حجم أيقونة متجاوب
            ),
          ),

          const SizedBox(width: 20), // مسافة ثابتة

          // 4. أيقونة الشخص
          Icon(
            Icons.person,
            color: widget.textColor,
            size: responsiveIconSize,
          ), // استخدام حجم أيقونة متجاوب

          const SizedBox(width: 2), // مسافة ثابتة
          // 5. السعر
          Text(
            '${_totalPrice.toStringAsFixed(0)}\$', // عرض السعر بدون كسور
            style: TextStyle(
              fontSize: responsiveFontSize, // استخدام حجم خط متجاوب
              fontWeight: FontWeight.bold,
              color: widget.textColor,
              shadows: [
                Shadow(
                  blurRadius: 3.0,
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(1.0, 1.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
