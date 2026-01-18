import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tripto/l10n/app_localizations.dart';
// import 'package:tripto/main.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/SideMenu.dart';

class Cancellattion extends StatefulWidget {
  const Cancellattion({super.key});

  @override
  State<Cancellattion> createState() => _CancellattionState();
}

class _CancellattionState extends State<Cancellattion> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        // elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.cancellation1,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                ? Icons
                    .keyboard_arrow_right_outlined // في العربي: سهم لليمين
                : Icons
                    .keyboard_arrow_left_outlined, // في الإنجليزي: سهم لليسار
            size: 35,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(20), // نعومة الحواف
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 450, // أقصى عرض للويب
                      ),
                      child: Image.asset(
                        "assets/images/cancellation.png",
                        width: double.infinity, // يعتمد على عرض الـ ConstrainedBox
                        height: screenHeight * 0.20,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.cancellation2,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.cancellation3,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.cancellation4,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.cancellation5,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation6,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.cancellation7,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ), // ستايل أساسي
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.cancellation8,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            AppLocalizations.of(
                              context,
                            )!.cancellation9, // الجزء اللي عايزه Bold
                        // style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ), // ستايل أساسي
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.cancellation10,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            AppLocalizations.of(
                              context,
                            )!.cancellation11, // الجزء اللي عايزه Bold
                        // style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ), // ستايل أساسي
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.cancellation12,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            AppLocalizations.of(
                              context,
                            )!.cancellation13, // الجزء اللي عايزه Bold
                        // style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ), // ستايل أساسي
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.cancellation14,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            AppLocalizations.of(
                              context,
                            )!.cancellation15, // الجزء اللي عايزه Bold
                        // style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.cancellation16,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation17,
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ), // ستايل أساسي
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.cancellation18,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            AppLocalizations.of(
                              context,
                            )!.cancellation19, // الجزء اللي عايزه Bold
                        // style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ), // ستايل أساسي
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.cancellation20,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            AppLocalizations.of(
                              context,
                            )!.cancellation21, // الجزء اللي عايزه Bold
                        // style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ), // ستايل أساسي
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.cancellation22,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            AppLocalizations.of(
                              context,
                            )!.cancellation23, // الجزء اللي عايزه Bold
                        // style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.cancellation24,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation25,
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation26,
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation27,
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation28,
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation29,
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation30,
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.cancellation31,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation32,
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation33,
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation34,
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation35,
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.cancellation36,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation37,
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ), // ستايل أساسي
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.cancellation38,
                      ),
                      TextSpan(
                        text:
                            AppLocalizations.of(
                              context,
                            )!.cancellation39, // الجزء اللي عايزه Bold
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            AppLocalizations.of(
                              context,
                            )!.cancellation40, // الجزء اللي عايزه Bold
                        // style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ), // ستايل أساسي
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.cancellation41,
                      ),
                      TextSpan(
                        text:
                            AppLocalizations.of(
                              context,
                            )!.cancellation42, // الجزء اللي عايزه Bold
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            AppLocalizations.of(
                              context,
                            )!.cancellation43, // الجزء اللي عايزه Bold
                        // style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation44,
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.cancellation45,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation46,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.cancellation47,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation48,
                style: const TextStyle(fontSize: 16),
              ),
            Center(
  child: Container(
    width: 400,
    height: 100,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/Logo.png"),
        fit: BoxFit.contain,
      ),
    ),
  ),
),


            ],
          ),
        ),
      ),
    );
  }
}
