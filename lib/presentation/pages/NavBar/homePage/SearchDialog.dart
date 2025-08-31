import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tripto/presentation/pages/SlideBar/category/CategoryPages/CategoryGold.dart';
import 'package:tripto/presentation/pages/SlideBar/category/CategoryPages/DiamondCategory.dart';
import 'package:tripto/presentation/pages/SlideBar/category/CategoryPages/PlatinumCategory.dart'; // لتنسيق التواريخ

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

  // دالة لاختيار تاريخ البداية
  Future<void> _pickStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  // دالة لاختيار تاريخ النهاية
  Future<void> _pickEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? (_startDate ?? DateTime.now()),
      firstDate: _startDate ?? DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _endDate = picked;
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
            "Search On Trips",
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

          // اختيار تاريخ البداية والنهاية
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _pickStartDate(context),
                  child: Text(
                    _startDate == null
                        ? "Start Date"
                        : dateFormat.format(_startDate!),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _pickEndDate(context),
                  child: Text(
                    _endDate == null
                        ? "End Date"
                        : dateFormat.format(_endDate!),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // 🔹 الكاتيجوري بنفس حجم الأزرار
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
                    height: 120, // نفس ارتفاع زرار التاريخ
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
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
              ElevatedButton(
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
            ],
          ),
        ],
      ),
    );
  }
}
