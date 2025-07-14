import 'package:flutter/material.dart';

import 'package:tripto/core/constants/CustomButton.dart'; // سيبقى هنا إذا احتجته في App
import 'package:tripto/data/models/Saved_model.dart';
import 'package:tripto/presentation/pagess/PersonCounterWithPriceWithCountry.dart';
import 'package:tripto/presentation/pagess/navbar_pages/Favorite_page.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/RightButtons.dart';
import 'package:tripto/presentation/app/vedio_player_page.dart';
import 'package:tripto/presentation/pagess/navbar_pages/activities.dart';
import 'package:tripto/presentation/pagess/navbar_pages/profile_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;
  // لن نستخدم bookingPricePerPerson هنا لأنه سيتم التعامل معه في VideoPlayerPage
  // final double _bookingPricePerPerson = 250.0;

  final List<Widget> _pages = [
    const VideoPlayerPage(), // VideoPlayerPage ستحتوي على عناصرها الخاصة الآن
    const Activities(),
    ProfilePage(), // افتراض أن ProfilePage يمكن أن تكون ثابتة
    //const SavedHistory(), // تم تغيير الاسم ليتوافق مع اصطلاحات التسمية
  ];

  final List<IconData> _icons = const [
    Icons.home,
    Icons.extension,
    Icons.person_2_outlined,
    Icons.favorite_border,
  ];

  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // تعرض الصفحة الحالية (بما في ذلك VideoPlayerPage مع عناصرها الآن)
          _pages[_currentIndex],

          // أيقونة البحث - ستظل ثابتة
          Positioned(
            top: screenHeight * 0.07,
            right: screenWidth * 0.05,
            child: const Icon(Icons.search, color: Colors.white, size: 30),
          ),

          // شريط التنقل السفلي - سيظل ثابتًا
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30, left: 32, right: 32),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  color: Colors.black.withOpacity(0.8),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(_icons.length, (index) {
                      return GestureDetector(
                        onTap: () => _changePage(index),
                        child: Icon(
                          _icons[index],
                          color:
                              _currentIndex == index
                                  ? Colors.white
                                  : Colors.grey,
                          size: 28,
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
