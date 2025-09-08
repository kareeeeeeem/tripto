import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTripBySUB/SearchOnTripBySubDestination_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTripBySUB/SearchOnTripBySubDestination_Event.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byCategory/SearchOnTripByCategory_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byCategory/SearchOnTripByCategory_Event.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byDate/SearchOnTripByDate_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byDate/SearchOnTripByDate_Event.dart';
import 'package:tripto/presentation/pages/NavBar/homePage/search/DateCardStandalone.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({super.key});

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  final TextEditingController _subDestinationController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  int selectedCategoryIndex = -1;

  Future<void> _pickDateRange(BuildContext context) async {
    final result = await showDialog<Map<String, DateTime?>>(
      context: context,
      builder: (ctx) => DateCardStandalone(
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        initialRangeStart: _startDate,
        initialRangeEnd: _endDate,
      ),
    );

    if (result != null) {
      setState(() {
        _startDate = result['range_start'];
        _endDate = result['range_end'];
      });
    }
  }

  Widget _buildCategory(String label, IconData iconData, Color color, int index) {
    final isSelected = selectedCategoryIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedCategoryIndex = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black, // نص ثابت
            ),
          ),

          const SizedBox(height: 8),
          
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? 80 : 70,  // يكبر لو متحدد
            height: isSelected ? 80 : 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: isSelected
                  ? [BoxShadow(color: Colors.black26, blurRadius: 6)]
                  : [],
            ),
            child: Icon(
              iconData,
              size: isSelected ? 60 : 50,  // يكبر لو متحدد
              color: color,  // اللون ثابت
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final size = MediaQuery.of(context).size;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return SizedBox(
      height: size.height * 0.65,
      width: size.width * 0.9,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isArabic ? "بحث" : "Search",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.08),

            // إدخال الوجهة الفرعية
            TextField(
              controller: _subDestinationController,
              decoration: InputDecoration(
                hintText: isArabic ? "وجهة فرعية (مثال: الجيزة)" : "Sub-destination (e.g., Giza)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.lightBlue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.lightBlue),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),

            // اختيار التاريخ
            ElevatedButton(
              onPressed: () => _pickDateRange(context),
              child: Text(
                (_startDate == null || _endDate == null)
                    ? (isArabic ? "اختر التاريخ" : "Select Date")
                    : "${dateFormat.format(_startDate!)} → ${dateFormat.format(_endDate!)}",
              ),
            ),
            SizedBox(height: size.height * 0.04),

            // اختيار الكاتيجوري
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCategory('Gold', Icons.diamond, Colors.amber, 0),
                _buildCategory('Diamond', Icons.diamond_outlined, Colors.blueAccent, 1),
                _buildCategory('Platinum', Icons.diamond_outlined, Colors.grey, 2),
              ],
            ),
            SizedBox(height: size.height * 0.05),

            // أزرار التحكم
            // أزرار التحكم
Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // البحث بالتاريخ
          if (_startDate != null && _endDate != null) {
            context.read<SearchTripByDateBloc>().add(
              FetchTripsByDate(from: _startDate!, to: _endDate!),
            );
          }

          // البحث بالكاتيجوري
          if (selectedCategoryIndex != -1) {
            context.read<SearchTripByCategoryBloc>().add(
              FetchTripsByCategory(category: selectedCategoryIndex + 1),
            );
          }

          // البحث بالـ subDestination
          if (_subDestinationController.text.isNotEmpty) {
            context.read<SearchTripBySubDestinationBloc>().add(
              FetchTripsBySubDestination(
                subDestination: _subDestinationController.text.trim(),
              ),
            );
          }

          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF002E70),
        ),
        child: Text(
          isArabic ? 'حسناً' : 'Ok',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
    const SizedBox(height: 8),
    SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context, null),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
        child: Text(
          isArabic ? 'إلغاء' : 'Cancel',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
    const SizedBox(height: 8),
    // زر Back to all trips بنفس لوجيك VideoPlayerScreen
    SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Reset الرحلات
          context.read<SearchTripByDateBloc>().add(FetchTripsByDate(
            from: DateTime(2000),
            to: DateTime(2100),
          ));
          context.read<SearchTripByCategoryBloc>().add(FetchTripsByCategory(category: 0));
          context.read<SearchTripBySubDestinationBloc>().add(FetchTripsBySubDestination(subDestination: ''));

          Navigator.pop(context); // اغلاق الـ Dialog
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF002E70),
        ),
        child: Text(
          isArabic ? 'العودة لكل الرحلات' : 'Back to all trips',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  ],
),

          ],
        ),
      ),
    );
  }
}
