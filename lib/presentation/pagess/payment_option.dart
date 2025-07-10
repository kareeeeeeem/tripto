import 'package:flutter/material.dart';
import '../../core/models/paymentoption_model.dart';

class PaymentOption extends StatefulWidget {
  const PaymentOption({super.key});

  @override
  State<PaymentOption> createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  String selectedMethod = 'master';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Payment',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left_outlined,
            size: 35,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              PaymentOptionCard(
                imagePath: 'assets/images/mastercard.png',
                label: 'Master Card',
                value: 'master',
                groupValue: selectedMethod,
                onChanged: (value) {
                  setState(() {
                    selectedMethod = value!;
                  });
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.003),
              PaymentOptionCard(
                imagePath: 'assets/images/paypal.png',
                label: 'PayPal',
                value: 'paypal',
                groupValue: selectedMethod,
                onChanged: (value) {
                  setState(() {
                    selectedMethod = value!;
                  });
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.003),

              PaymentOptionCard(
                imagePath: 'assets/images/visa.png',
                label: 'Visa',
                value: 'visa',
                groupValue: selectedMethod,
                onChanged: (value) {
                  setState(() {
                    selectedMethod = value!;
                  });
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/paymentDestination');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
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
