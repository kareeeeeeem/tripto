import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tripto/presentation/pages/NavBar/homePage/DateCardStandalone.dart';
import 'package:tripto/presentation/pages/SlideBar/category/CategoryPages/CategoryGold.dart';
import 'package:tripto/presentation/pages/SlideBar/category/CategoryPages/DiamondCategory.dart';
import 'package:tripto/presentation/pages/SlideBar/category/CategoryPages/PlatinumCategory.dart';
import 'package:tripto/presentation/pages/SlideBar/date/DateCard.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({super.key});

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  final TextEditingController _searchController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  int selectedCategoryIndex = -1; // 🔹 عشان نحدد الكاتيجوري

  // دالة تفتح الـ DateCard Dialog
  Future<void> _pickDateRange(BuildContext context) async {
    final result = await showDialog<Map<String, DateTime?>>(
      context: context,
      builder: (ctx) {
        return DateCardStandalone(
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          initialRangeStart: _startDate,
          initialRangeEnd: _endDate,
        );
      },
    );

    if (result != null) {
      setState(() {
        _startDate = result['range_start'];
        _endDate = result['range_end'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');

    return SizedBox(
      height: 500,
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Search",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // حقل البحث
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "trip",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.lightBlue),
              ),
            ),
          ),
          const SizedBox(height: 30),

          // زر واحد لاختيار الرينج
          ElevatedButton(
            onPressed: () => _pickDateRange(context),
            child: Text(
              (_startDate == null || _endDate == null)
                  ? "Select Date"
                  : "${dateFormat.format(_startDate!)} → ${dateFormat.format(_endDate!)}",
            ),
          ),

          const SizedBox(height: 40),

          // 🔹 الكاتيجوري
          Row(
            children: [
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategoryIndex = 0;
                    });
                  },
                  child: SizedBox(
                    height: 120,
                    child: GoldCategory(isSelected: selectedCategoryIndex == 0),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategoryIndex = 1;
                    });
                  },
                  child: SizedBox(
                    height: 120,
                    child: DiamondCategory(
                      isSelected: selectedCategoryIndex == 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategoryIndex = 2;
                    });
                  },
                  child: SizedBox(
                    height: 120,
                    child: PlatinumCategory(
                      isSelected: selectedCategoryIndex == 2,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 50),

          // أزرار التأكيد والإلغاء
          // أزرار التأكيد والإلغاء
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'searchText': _searchController.text,
                      'startDate': _startDate,
                      'endDate': _endDate,
                      'category': selectedCategoryIndex,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF002E70),
                  ),
                  child: Text(
                    Localizations.localeOf(context).languageCode == 'ar'
                        ? 'حسناً'
                        : 'Ok',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                  ),
                  child: Text(
                    Localizations.localeOf(context).languageCode == 'ar'
                        ? 'إلغاء'
                        : 'Cancel',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
