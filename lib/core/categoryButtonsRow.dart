import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byCategory/SearchOnTripByCategory_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byCategory/SearchOnTripByCategory_Event.dart'; // 💡 تم الافتراض أن FetchAllTrips معرَّف هنا

class CategoryButtonsRow extends StatefulWidget {
  final Function(int categoryIndex) onCategorySearch;
  final int? initialSelectedIndex; 

  const CategoryButtonsRow({
    super.key,
    required this.onCategorySearch,
    this.initialSelectedIndex,
  });

  @override
  State<CategoryButtonsRow> createState() => _CategoryButtonsRowState();
}

class _CategoryButtonsRowState extends State<CategoryButtonsRow> {
  late int selectedCategoryIndex;
  late final AppLocalizations loc;
  
  @override
  void initState() {
    super.initState();
    selectedCategoryIndex = widget.initialSelectedIndex ?? -1;
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loc = AppLocalizations.of(context)!;
  }

  void _executeSearch(int index) {
    if (selectedCategoryIndex == index) {
      // 1. إذا تم الضغط مرتين على نفس الفئة، قم بإلغاء التحديد
      setState(() {
        selectedCategoryIndex = -1; 
      });

      // 2. إرسال حدث جلب "كل الرحلات" إلى الـ Bloc
      // 🚨 هذا هو السطر الذي يتطلب تعريف FetchAllTrips في ملف الـ Event
      context.read<SearchTripByCategoryBloc>().add(
          const FetchAllTrips()); 
          
      // 3. إبلاغ الـ Parent (HomePage) بإلغاء التحديد
      widget.onCategorySearch(-1); 
      
    } else {
      setState(() {
        selectedCategoryIndex = index;
      });
      
      // 1. تنفيذ البحث عن طريق البلوك لفئة جديدة
      context.read<SearchTripByCategoryBloc>().add(
          FetchTripsByCategory(category: index));
          
      // 2. إبلاغ الـ Parent (HomePage) بأن البحث تم
      widget.onCategorySearch(index); 
    }
  }

  // دالة بناء زر الفئة المصغر (أيقونة فقط)
  Widget _buildSmallCategoryButton(String label, IconData iconData, Color color, int index) {
    final isSelected = selectedCategoryIndex == index;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Tooltip(
        message: label,
        child: Container(
          width: 40, 
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? color.withOpacity(0.8) : Colors.white12, 
            border: Border.all(color: isSelected ? color : Colors.white24, width: isSelected ? 2 : 1),
          ),
          child: IconButton(
            icon: Icon(iconData, size: 20, color: isSelected ? Colors.white : color.withOpacity(0.8)),
            onPressed: () => _executeSearch(index),
            padding: EdgeInsets.zero,
            style: IconButton.styleFrom(
              minimumSize: Size.zero, 
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // صف أزرار الفئات
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            // 0: Gold
            _buildSmallCategoryButton(loc.gold, Icons.diamond, Colors.amber.shade700, 0),
            // 1: Diamond
            _buildSmallCategoryButton(loc.diamond, Icons.diamond_outlined, Colors.blueAccent, 1),
            // 2: Platinum
            _buildSmallCategoryButton(loc.platinum, Icons.diamond_outlined, Colors.grey.shade600, 2),
        ],
    );
  }
}