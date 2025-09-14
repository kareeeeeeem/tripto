import 'package:flutter/material.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/presentation/app/app.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/SideMenu.dart';

class MyTripsPage extends StatelessWidget {
  const MyTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.mytrips,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SideMenu()),
              (route) => false,
            );
          },
          icon: Icon(
            Localizations.localeOf(context).languageCode == 'ar'
                ? Icons.keyboard_arrow_right_outlined
                : Icons.keyboard_arrow_left_outlined,
            size: 35,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.02,
          MediaQuery.of(context).size.height * 0.1,
          MediaQuery.of(context).size.width * 0.02,
          0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 243, 241, 241),
            borderRadius: BorderRadius.circular(16),
          ),
          height: MediaQuery.of(context).size.height * 0.6,
          child: ListView.builder(
            
            padding: const EdgeInsets.all(8),
            itemCount: 6, // عدد الرحلات التجريبية
            itemBuilder: (context, index) {
              return Card(
                  color: Colors.white, // <- هذا هو التعديل

                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  
                  leading: const Icon(
                    Icons.flight_takeoff,
                    color: Color(0xFF002E70),
                    size: 30,
                  ),
                  title: Text(
                    'Trip ${index + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text('Destination details here'),
                  trailing: Icon(
                    Localizations.localeOf(context).languageCode == 'ar'
                        ? Icons.keyboard_arrow_left
                        : Icons.keyboard_arrow_right,
                  ),
                  onTap: () {
                    // هنا ممكن تضيف فتح تفاصيل الرحلة
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
