import 'package:flutter/material.dart';
import 'package:tripto/presentation/pages/NavBar/home/homepage/VedioPlayerPage.dart';
import 'package:tripto/main.dart'; // نحتاج لـ videoPlayerScreenKey

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _scrollToNextPage() {
    try {
      final state = videoPlayerScreenKey.currentState;
      if (state != null && (state as dynamic).nextPage != null) {
        (state as dynamic).nextPage(); 
      } else {
        // يمكنك هنا عرض رسالة (مثل SnackBar) إذا أردت
        debugPrint('ERROR: nextPage() function not found or key state is null. Please ensure it exists in VideoPlayerScreenState.');
      }
    } catch (e) {
      debugPrint('Error calling nextPage(): $e');
    }
  }



  void _scrollToPreviousPage() {
    try {
      final state = videoPlayerScreenKey.currentState;
      if (state != null && (state as dynamic).previousPage != null) {
        (state as dynamic).previousPage(); 
      } else {
        debugPrint('ERROR: previousPage() function not found or key state is null. Please ensure it exists in VideoPlayerScreenState.');
      }
    } catch (e) {
       debugPrint('Error calling previousPage(): $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double tabletBreakpoint = 600;

        if (constraints.maxWidth > tabletBreakpoint) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Row( // Row لتوسيط الفيديو ووضع الأزرار على الجانبين
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 450,  // أقصى عرض (لتصميم Shorts)
                      maxHeight: 850, // أقصى ارتفاع
                    ),
                    child: VideoPlayerScreen(key: videoPlayerScreenKey),
                  ),

                  SizedBox(
                    width: (constraints.maxWidth - 450) / 2 > 80 ? 80 : (constraints.maxWidth - 450) / 2, 
                    height: 850, // نفس ارتفاع الفيديو
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.keyboard_arrow_up, size: 40, color: Colors.white70),
                            onPressed: _scrollToPreviousPage,
                            tooltip: 'الفيديو السابق',
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white10,
                            ),
                          ),
                          const SizedBox(height: 20),
                          IconButton(
                            icon: const Icon(Icons.keyboard_arrow_down, size: 40, color: Colors.white70),
                            onPressed: _scrollToNextPage,
                            tooltip: 'الفيديو التالي',
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(), // يضمن أن كل شيء يتوسط الشاشة
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.black,
            body: VideoPlayerScreen(key: videoPlayerScreenKey),
          );
        }
      },
    );
  }
}
