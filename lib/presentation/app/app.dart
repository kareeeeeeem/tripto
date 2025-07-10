import 'package:flutter/material.dart';

import 'package:tripto/core/constants/CustomButton.dart';
import 'package:tripto/presentation/pagess/PersonCounterWithPriceWithCountry.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/RightButtons.dart';
import 'package:tripto/presentation/app/vedio_player_page.dart';
import 'package:tripto/presentation/pagess/navbar_pages/activities.dart';
import 'package:tripto/presentation/pagess/navbar_pages/profile_page.dart';
import 'package:tripto/presentation/pagess/payment_option.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;
  double _bookingPricePerPerson = 250.0;

  final List<Widget> _pages = [
    const VideoPlayerPage(),
    const Activities(),
    ProfilePage(),
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
          _pages[_currentIndex],

          if (_currentIndex == 0)
            Positioned(
              top: screenHeight * 0.07,
              right: screenWidth * 0.05,
              child: const Icon(Icons.search, color: Colors.white, size: 30),
            ),

          if (_currentIndex == 0)
            Positioned(
              top: screenHeight * 0.1,
              right: screenWidth * 0.38,
              child: const Text(
                'Egypt',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          if (_currentIndex == 0)
            Positioned(
              right: 15,
              bottom: screenHeight * 0.23,
              child: const RightButtons(),
            ),

          if (_currentIndex == 0)
            Positioned(
              bottom: screenHeight * 0.20,
              left: 20,
              right: screenWidth * 0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Alex, Egypt',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black54,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  PersonCounterWithPriceWithContry(
                    basePricePerPerson: _bookingPricePerPerson,
                    textColor: Colors.white,
                    iconColor: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
            ),

          if (_currentIndex == 0)
            Positioned(
              bottom: screenHeight * 0.12,
              left: 20,
              right: 20,
              child: Center(
                child: CustomButton(
                  text: "Book Now",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentOption()),
                    );
                  },
                  width: screenWidth * 0.80,
                  height: 40,
                ),
              ),
            ),

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
