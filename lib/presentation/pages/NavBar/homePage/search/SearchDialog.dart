import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTripByCategory_Bloc/SearchOnTripBySubDestination_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTripByCategory_Bloc/SearchOnTripBySubDestination_Event.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byCategory/SearchOnTripByCategory_Event.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byCategory/SearchOnTripByCategory_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byDate/SearchOnTripByDate_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byDate/SearchOnTripByDate.dart';
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
  final TextEditingController _subDestinationController =
      TextEditingController();
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

  String? getSelectedCategory() {
    switch (selectedCategoryIndex) {
      case 0:
        return "1"; // Gold
      case 1:
        return "2"; // Diamond
      case 2:
        return "3"; // Platinum
      default:
        return null;
    }
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
              "Search",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.10),

            // 🔹 حقل البحث العام

            // 🔹 حقل Sub-destination
            TextField(
              controller: _subDestinationController,
              decoration: InputDecoration(
                hintText: "Sub-destination (e.g., Giza)",
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

            // زر اختيار الرينج
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
                      final selectedCategory = getSelectedCategory();
                      final subDestination =
                          _subDestinationController.text.trim();

                      // 🔹 فلترة التاريخ
                      if (_startDate != null && _endDate != null) {
                        context.read<FilteredTripsBloc>().add(
                          FilterTripsByDateRangeEvent(_startDate!, _endDate!),
                        );
                      }

                      // 🔹 فلترة الكاتيجوري
                      if (selectedCategory != null) {
                        context.read<CategoryTripBloc>().add(
                          FetchTripsByCategoryEvent(selectedCategory),
                        );
                      }

                      // 🔹 فلترة Sub-destination
                      if (subDestination.isNotEmpty) {
                        context.read<SearchSubDestinationBloc>().add(
                          SearchSubDestinationRequested(subDestination),
                        );
                      }

                      // 🔹 إرجاع البيانات
                      Navigator.pop(context, {
                        'searchText': _searchController.text,
                        'startDate': _startDate,
                        'endDate': _endDate,
                        'category': selectedCategory,
                        'subDestination': subDestination,
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
