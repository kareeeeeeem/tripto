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
import 'package:tripto/presentation/pages/SlideBar/category/CategoryPages/CategoryGold.dart';
import 'package:tripto/presentation/pages/SlideBar/category/CategoryPages/DiamondCategory.dart';
import 'package:tripto/presentation/pages/SlideBar/category/CategoryPages/PlatinumCategory.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({super.key});

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {

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
            SizedBox(height: size.height * 0.10),

            // ✅ إدخال الوجهة الفرعية
            TextField(
              controller: _subDestinationController,
              decoration: InputDecoration(
                hintText: isArabic
                    ? "وجهة فرعية (مثال: الجيزة)"
                    : "Sub-destination (e.g., Giza)",
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

            // ✅ اختيار التاريخ
            ElevatedButton(
              onPressed: () => _pickDateRange(context),
              child: Text(
                (_startDate == null || _endDate == null)
                    ? (isArabic ? "اختر التاريخ" : "Select Date")
                    : "${dateFormat.format(_startDate!)} → ${dateFormat.format(_endDate!)}",
              ),
            ),

            SizedBox(height: size.height * 0.04),

            // ✅ اختيار الكاتيجوري
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

            // ✅ أزرار التحكم
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(


                  onPressed: () {
                    // البحث بناءً على التاريخ
                    if (_startDate != null && _endDate != null) {
                      context.read<SearchTripByDateBloc>().add(
                        FetchTripsByDate(
                          from: _startDate!,
                          to: _endDate!,
                        ),
                      );
                    }

                  // البحث بناءً على الكاتيجوري
                  if (selectedCategoryIndex != -1) {
                    final categoryNumber = selectedCategoryIndex + 1;
                    context.read<SearchTripByCategoryBloc>().add(
                      FetchTripsByCategory(category: categoryNumber),
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
