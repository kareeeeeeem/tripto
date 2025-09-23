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

            TextField(
              controller: _subDestinationController,
              decoration: InputDecoration(
                hintText: isArabic ? "الدوله (مثال: الرياض)" : "Sub-destination (example: Riyadh)",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.lightBlue)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.lightBlue)),
              ),
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
