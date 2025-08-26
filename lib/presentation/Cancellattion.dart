import 'package:flutter/material.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/main.dart';
import 'package:tripto/presentation/pages/SideMenu.dart';

class Cancellattion extends StatefulWidget {
  const Cancellattion({super.key});

  @override
  State<Cancellattion> createState() => _CancellattionState();
}

class _CancellattionState extends State<Cancellattion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        // elevation: 0,
        // scrolledUnderElevation: 0,
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
              Text(
                AppLocalizations.of(context)!.cancellation2,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.cancellation3,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.cancellation4,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.cancellation5,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation6,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.cancellation7,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
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
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.cancellation16,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
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
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.cancellation24,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation25,
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation26,
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation27,
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation28,
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation29,
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.cancellation30,
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
