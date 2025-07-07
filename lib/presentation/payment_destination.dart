import 'package:flutter/material.dart';

class PaymentDestination extends StatefulWidget {
  const PaymentDestination({super.key});

  @override
  State<PaymentDestination> createState() => _PaymentDestinationState();
}

class _PaymentDestinationState extends State<PaymentDestination> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Payment Destination',
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
                Center(child: Image.asset('assets/images/museum.png' , width:double.infinity) ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
