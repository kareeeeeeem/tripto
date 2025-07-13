import 'package:flutter/material.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/Hotels.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/InfoCard.dart';

class HotelsDetailsModel extends StatefulWidget {
  const HotelsDetailsModel({super.key});

  @override
  State<HotelsDetailsModel> createState() => _HotelsDetailsModel();
}

class _HotelsDetailsModel extends State<HotelsDetailsModel> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(); // UI اتمسح
  }
}
class Bookinghotel {
  final String title;
  final String image;
  final String description;

  Bookinghotel({
    required this.title,
    required this.image,
    required this.description,
  });
}

List<Bookinghotel> bookinghotels = [
  Bookinghotel(
    title: "Hilton",
    image: "assets/images/hilton.png",
    description: "",
  ),
];

void openbottomsheet(BuildContext context) {
  showDialog(
    context: context,
    builder:
        (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            width: MediaQuery.of(context).size.width * 0.9,
            child: const Hotels(),
          ),
    ),
  );
}
