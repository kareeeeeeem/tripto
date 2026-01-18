import 'package:flutter/material.dart';

class PersonCounterWithPrice extends StatefulWidget {
  final double
  basePricePerPerson; // السعر الأساسي للشخص الواحد (يمكن تحديده عند الاستخدام)
  final Color textColor;
  final Color iconColor;
  final Color backgroundColor; // لون خلفية العداد (يمكن تحديده عند الاستخدام)
  final int maxPersons;

  final double carPrice;
  final double? initialCarPrice;

  final double activityPrice;
  final double? initialActivityPrice;

  final double hotelPrice;
  final double? initialHotelPrice;

  const PersonCounterWithPrice({
    super.key,
    this.basePricePerPerson = 0.0,
    this.textColor = Colors.white,
    this.iconColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.maxPersons = 30,

    this.carPrice = 0,
    this.initialCarPrice,

    this.activityPrice = 0,
    this.initialActivityPrice,

    this.hotelPrice = 0,
    this.initialHotelPrice,
  });

  @override
  // ignore: library_private_types_in_public_api
  PersonCounterWithPriceState createState() => PersonCounterWithPriceState();
}

class PersonCounterWithPriceState extends State<PersonCounterWithPrice> {
  int _numberOfPeople = 1; // العدد الأولي للأشخاص

  double _totalPrice = 0.0; // السعر الإجمالي

  double _selectedCarPrice = 0.0;

  double _selectedActivityPrice = 0.0;

  double _selectedHotelPrice = 0.0;

    // ✅ Getters علشان تستعملهم من بره
  int get currentPersons => _numberOfPeople;
  double get totalPrice => _totalPrice;

  @override
  void initState() {
    super.initState();

    if (widget.initialCarPrice != null) {
      _selectedCarPrice = widget.initialCarPrice!;
    }
    if (widget.initialActivityPrice != null) {
      _selectedActivityPrice = widget.initialActivityPrice!;
    }
    if (widget.initialHotelPrice != null) {
      _selectedHotelPrice = widget.initialHotelPrice!;
    }
    _updateTotalPrice();
  }

  void setSelectedCarPrice(double price) {
    setState(() {
      _selectedCarPrice = price;
      _updateTotalPrice();
    });
  }
  // ✅ جديد

  void setSelectedActivityPrice(double price) {
    setState(() {
      _selectedActivityPrice = price;
      _updateTotalPrice();
    });
  }

  void setSelectedHotelPrice(double pricePerNight, int numberOfNights) {
    setState(() {
      _selectedHotelPrice = pricePerNight * numberOfNights;
      _updateTotalPrice();
    });
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
        _numberOfPeople--;
        _updateTotalPrice();
      }
    });
  }

  void _updateTotalPrice() {
    _totalPrice =
        (_numberOfPeople * widget.basePricePerPerson) +
        _selectedCarPrice +
        _selectedActivityPrice +
        _selectedHotelPrice;
  }

  @override
  void didUpdateWidget(covariant PersonCounterWithPrice oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.carPrice != widget.carPrice ||
        oldWidget.basePricePerPerson != widget.basePricePerPerson ||
        oldWidget.activityPrice != widget.activityPrice ||
        oldWidget.hotelPrice != widget.hotelPrice) {
      _updateTotalPrice();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final double responsiveWidth = screenWidth > 400 ? 400 : screenWidth; 

    // استخدام responsiveWidth في حسابات الحجم بدلاً من screenWidth
    final double responsiveRadius =
        responsiveWidth * 0.04; // نصف قطر دائرة الأيقونات (تم تعديل النسبة قليلاً)
    final double responsiveIconSize =
        responsiveWidth * 0.05; // حجم الأيقونات 
    final double responsiveFontSize = responsiveWidth * 0.06; // حجم الخطوط

    return Container(
      // ⚠️ إضافة قيود العرض القصوى هنا (مهم لتحديد عرض الـ Row)
      constraints: const BoxConstraints(maxWidth: 400),
      
      // تحديد المسافة الأفقية كنسبة مئوية من العرض المقيد
      padding: EdgeInsets.symmetric(
        // استخدام responsiveWidth في الـ Padding أيضاً
        horizontal: responsiveWidth * 0.03, // مسافة أفقية متجاوبة
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
              radius: responsiveRadius, // ✅ استخدام القيمة الجديدة
              backgroundColor: widget.backgroundColor.withOpacity(0.7),
              child: Icon(
                Icons.add,
                color: widget.iconColor,
                size: responsiveIconSize, // ✅ استخدام القيمة الجديدة
              ),
            ),
          ),

          const SizedBox(width: 10), // مسافة ثابتة
          // 2. عدد الأشخاص
          Text(
            '$_numberOfPeople',
            style: TextStyle(
              fontSize: responsiveFontSize, // ✅ استخدام القيمة الجديدة
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
              radius: responsiveRadius, // ✅ استخدام القيمة الجديدة
              backgroundColor: widget.backgroundColor.withOpacity(0.7),
              child: Icon(
                Icons.remove,
                color: widget.iconColor,
                size: responsiveIconSize, // ✅ استخدام القيمة الجديدة
              ),
            ),
          ),

          const SizedBox(width: 20), // مسافة ثابتة
          // 4. أيقونة الشخص
          Icon(
            Icons.person,
            color: widget.textColor,
            size: responsiveIconSize, // ✅ استخدام القيمة الجديدة
          ),

          const SizedBox(width: 2), // مسافة ثابتة
          // 5. السعر
          Text(
            '${_totalPrice.toStringAsFixed(0)}\$', // عرض السعر بدون كسور
            style: TextStyle(
              fontSize: responsiveFontSize, // ✅ استخدام القيمة الجديدة
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
