import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, size: 35),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              "Enter the code",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const Text(
              "We sent You a code",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF8A8A8A),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "We sent it to  ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF8A8A8A),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                Text(
                  ("${widget.phoneNumber}"),
                  style: const TextStyle(
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
                  ? "You can request code again in $_start s"
                  : "You can request the code again",
              style: const TextStyle(fontSize: 16),
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
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
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
                    child: const Text("Resend Code"),
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
