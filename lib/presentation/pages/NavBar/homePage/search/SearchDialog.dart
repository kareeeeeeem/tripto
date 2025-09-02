import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTrip_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/searchontrip_Event.dart';
import 'package:tripto/presentation/pages/NavBar/homePage/search/DateCardStandalone.dart';
import 'package:tripto/presentation/pages/SlideBar/category/CategoryPages/CategoryGold.dart';
import 'package:tripto/presentation/pages/SlideBar/category/CategoryPages/DiamondCategory.dart';
import 'package:tripto/presentation/pages/SlideBar/category/CategoryPages/PlatinumCategory.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({super.key});

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  final TextEditingController _searchController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  int selectedCategoryIndex = -1;

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
    final size = MediaQuery.of(context).size; // ✅ حجم الشاشة
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return SizedBox(
      height: size.height * 0.55, // ياخد 70% من ارتفاع الشاشة
      width: size.width * 0.9, // ياخد 90% من عرض الشاشة
      child: SingleChildScrollView(
        // ✅ علشان مايحصلش overflow
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Search",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.02),

            // حقل البحث
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "trip",
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

            // زر واحد لاختيار الرينج
            ElevatedButton(
              onPressed: () => _pickDateRange(context),
              child: Text(
                (_startDate == null || _endDate == null)
                    ? "Select Date"
                    : "${dateFormat.format(_startDate!)} → ${dateFormat.format(_endDate!)}",
              ),
            ),

            SizedBox(height: size.height * 0.04),

            // 🔹 الكاتيجوري
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedCategoryIndex = 0),
                    child: SizedBox(
                      height: size.height * 0.15,
                      child: GoldCategory(
                        isSelected: selectedCategoryIndex == 0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.02),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedCategoryIndex = 1),
                    child: SizedBox(
                      height: size.height * 0.15,
                      child: DiamondCategory(
                        isSelected: selectedCategoryIndex == 1,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.02),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedCategoryIndex = 2),
                    child: SizedBox(
                      height: size.height * 0.15,
                      child: PlatinumCategory(
                        isSelected: selectedCategoryIndex == 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: size.height * 0.05),

            // أزرار التأكيد والإلغاء
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_startDate != null && _endDate != null) {
                        // إرسال Event للـ FilteredTripsBloc
                        context.read<FilteredTripsBloc>().add(
                          FilterTripsByDateRangeEvent(_startDate!, _endDate!),
                        );
                      }

                      // إرجاع باقي بيانات البحث
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
                      isArabic ? 'حسناً' : 'Ok',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.01),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, null),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                    ),
                    child: Text(
                      isArabic ? 'إلغاء' : 'Cancel',
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
