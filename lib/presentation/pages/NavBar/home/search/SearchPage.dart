import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTripBySUB/SearchOnTripBySubDestination_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTripBySUB/SearchOnTripBySubDestination_Event.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byCategory/SearchOnTripByCategory_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byCategory/SearchOnTripByCategory_Event.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byDate/SearchOnTripByDate_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byDate/SearchOnTripByDate_Event.dart';
import 'package:tripto/presentation/pages/NavBar/home/search/DateCardStandalone.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _subDestinationController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  int selectedCategoryIndex = -1;
  List? allSubDestinations;
  int? selectedSubDestinationId; // ضع هذا في أعلى الـ State class



  String _arabicDigits(String input) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    if (!isArabic) return input;

    const english = ['0','1','2','3','4','5','6','7','8','9'];
    const arabic = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩'];

    for (int i = 0; i < 10; i++) {
      input = input.replaceAll(english[i], arabic[i]);
    }
    return input;
  }
void _showDatePicker(BuildContext context) async {
  final result = await showDialog(
    context: context,
    builder: (context) => ArabicDateRangePicker(
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
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
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 8),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? 80 : 70,
            height: isSelected ? 80 : 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: isSelected ? [BoxShadow(color: Colors.black26, blurRadius: 6)] : [],
            ),
            child: Icon(iconData, size: isSelected ? 60 : 50, color: color),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd', Localizations.localeOf(context).languageCode);
    final size = MediaQuery.of(context).size;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    

   return Scaffold(
      backgroundColor:  Colors.white,
      appBar: AppBar(
      backgroundColor:  Colors.white,
      centerTitle:true,
      title: Text(isArabic ? "البحث عن رحله" : "Search on trip"),
        ),
        
        body: SingleChildScrollView(  
        padding: const EdgeInsets.all(16),
        child: Column(
    
          mainAxisSize: MainAxisSize.min,
          children: [
            
            // Text(isArabic ? "البحث عن رحله" : "Search on trip", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: size.height * 0.10),



            // اختيار التاريخ
              ElevatedButton.icon(
                onPressed: () => _showDatePicker(context),
                icon: const Icon(Icons.date_range, color: Colors.white),
                label: Text(
                  (_startDate == null || _endDate == null)
                      ? (isArabic ? "اختر التاريخ" : "Select Date")
                      : "${DateFormat('yyyy-MM-dd', 'ar').format(_startDate!)} → ${DateFormat('yyyy-MM-dd', 'ar').format(_endDate!)}",
                  style: const TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 4,
                  shadowColor: Colors.black45,
                ),
              ),

            SizedBox(height: size.height * 0.05),






            // اختيار الواجهه
TypeAheadField(
  controller: _subDestinationController,
  focusNode: FocusNode(),
  showOnFocus: true, // مهم جدًا لعرض كل الوجهات عند التركيز
  suggestionsCallback: (pattern) async {
    // جلب البيانات لو ما تم جلبها بعد
    if (allSubDestinations == null) {

      final response = await http
          .get(Uri.parse("https://tripto.blueboxpet.com/api/sub-destinations"));
                 CircularProgressIndicator(color: Color(0xFF002E70));

      if (response.statusCode == 200) {
        
        final List data = json.decode(response.body);
               CircularProgressIndicator(color: Color(0xFF002E70));

        setState(() {
          allSubDestinations = data;
        });
      }
    }

    // إذا كان pattern فارغ، أرجع كل الوجهات
    if (pattern.isEmpty) return allSubDestinations ?? [];

    return (allSubDestinations ?? []).where((sub) {
      final name = isArabic ? sub['name_ar'] : sub['name_en'];
      return name.toLowerCase().contains(pattern.toLowerCase());
    }).toList();
  },
  itemBuilder: (context, suggestion) {
    return ListTile(
      title: Text(isArabic ? suggestion['name_ar'] : suggestion['name_en']),
    );
  },
  onSelected: (suggestion) {
    _subDestinationController.text =
        isArabic ? suggestion['name_ar'] : suggestion['name_en'];
    selectedSubDestinationId = suggestion['id'];
  },
  builder: (context, controller, focusNode) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: isArabic
            ? "اختر الوجهة الفرعية (مثال: شرم الشيخ)"
            : "Select sub-destination (example: sharm El-shyk)",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.lightBlue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.lightBlue),
        ),
      ),
    );
  },
),
            SizedBox(height: size.height * 0.05),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCategory(isArabic ? "ذهبي" : "Gold", Icons.diamond, Colors.amber, 0),
                _buildCategory(isArabic ? "الماسي" : "Diamond", Icons.diamond_outlined, Colors.blueAccent, 1),
                _buildCategory(isArabic ? "بلاتيني" : 'Platinum', Icons.diamond_outlined, Colors.grey, 2),
              ],
            ),
            SizedBox(height: size.height * 0.05),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_startDate != null && _endDate != null) {
                        context.read<SearchTripByDateBloc>().add(FetchTripsByDate(from: _startDate!, to: _endDate!));
                      }
                      if (selectedCategoryIndex != -1) {
                        context.read<SearchTripByCategoryBloc>().add(FetchTripsByCategory(category: selectedCategoryIndex));
                      }
                      if (_subDestinationController.text.isNotEmpty) {
                        context.read<SearchTripBySubDestinationBloc>().add(FetchTripsBySubDestination(subDestination: _subDestinationController.text.trim()));
                      }
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF002E70)),
                    child: Text(isArabic ? 'حسناً' : 'Ok', style: const TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, null),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
                    child: Text(isArabic ? 'إلغاء' : 'Cancel', style: const TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 18, 114, 159)),
                    child: Text(isArabic ? 'كل الرحلات' : 'All trips', style: const TextStyle(color: Colors.white)),
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
