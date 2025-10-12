import 'package:flutter/material.dart';
import 'package:tripto/l10n/app_localizations.dart';

class NoInternetPage extends StatelessWidget {
  final VoidCallback? onRetry;

  const NoInternetPage({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/internet.png',
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.18,
                  fit: BoxFit.fitHeight,
                ),
                const SizedBox(height: 20),

                // عنوان
                Text(
                  AppLocalizations.of(context)!.errorConnection,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade400,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),

                // رسالة توضيحية
                // Text(
                //   AppLocalizations.of(context)!.noInternetMessage,
                //   textAlign: TextAlign.center,
                //   style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                // ),
                // SizedBox(height: MediaQuery.of(context).size.height * 0.07),

                // زرار المحاولة
                ElevatedButton.icon(
                  onPressed: onRetry ?? () {},
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: Text(
                    AppLocalizations.of(context)!.tryagain,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF002E70),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),

                Container(
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.18,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Logo.png"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
