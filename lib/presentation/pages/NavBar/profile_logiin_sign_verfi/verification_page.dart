import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tripto/l10n/app_localizations.dart';

class Verification extends StatefulWidget {
  final String phoneNumber;

  const Verification({super.key, required this.phoneNumber});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  int _start = 59;
  Timer? _timer;
  String _code = " ";
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _start = 59;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return; // ✅ نتأكد إن الwidget لسه موجود
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _timer!.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // لازم نلغي التايمر لما الصفحة تتقفل
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Localizations.localeOf(context).languageCode == 'ar'
                ? Icons
                .keyboard_arrow_right_outlined // في العربي: سهم لليمين
                : Icons.keyboard_arrow_left_outlined,
            size: 35,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.enterthecode,
              style:  GoogleFonts.markaziText(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Text(
              AppLocalizations.of(context)!.wesentyouacode,
              style:  GoogleFonts.markaziText(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF8A8A8A),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.request_code_again,
                  style:  GoogleFonts.markaziText(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF8A8A8A),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                Text(
                  (widget.phoneNumber),
                  style:  GoogleFonts.markaziText(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
                vertical: MediaQuery.of(context).size.height * 0.01,
              ),
              child: PinCodeTextField(
                appContext: context,
                length: 4,
                onChanged: (value) {
                  setState(() {
                    _code = value;
                    _isButtonEnabled = value.length == 4;
                  });
                },
                pinTheme: (PinTheme(
                  shape: PinCodeFieldShape.circle,
                  fieldHeight: 30,
                  fieldWidth: 40,
                  // activeFillColor: Colors.grey,
                  selectedColor: const Color(0xFF002E70),
                  activeColor: Colors.grey,
                  inactiveColor: Colors.grey,
                )),
                mainAxisAlignment: MainAxisAlignment.center,
                keyboardType: TextInputType.number,
              ),
            ),
            Text(
              _start > 0
                  ? AppLocalizations.of(
                context,
              )!.request_code_again_timer(_start.toString())
                  : AppLocalizations.of(context)!.request_code_again,
              style:  GoogleFonts.markaziText(fontSize: 16),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.025,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.878,
                height: MediaQuery.of(context).size.height * 0.05875,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF002E70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed:
                  _isButtonEnabled
                      ? () {
                    Navigator.pushNamed(context, '/ProfileCard');
                  }
                      : null,
                  child: Text(
                    AppLocalizations.of(context)!.confirm,
                    style:  GoogleFonts.markaziText(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            if (_start == 0)
              Padding(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.030,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      startTimer();
                    },
                    child: Text(AppLocalizations.of(context)!.resendcode),
                  ),
                ),
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}