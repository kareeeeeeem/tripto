import 'package:flutter/material.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/infocard.dart';

class InfoDetailsModel extends StatefulWidget {
  const InfoDetailsModel({super.key});

  @override
  State<InfoDetailsModel> createState() => _InfoDetailsModelState();
}

class _InfoDetailsModelState extends State<InfoDetailsModel> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(); // UI اتمسح
  }
}

// ================== MODELS ==================

class Tourismcompany {
  final String title;
  final String image;
  final String description;
  final int rate;

  Tourismcompany({
    required this.title,
    required this.image,
    required this.description,
    required this.rate,
  });
}

class FlyingCompany {
  final String title;
  final String image;
  final String description;

  FlyingCompany({
    required this.title,
    required this.image,
    required this.description,
  });
}

class Reservecar {
  final String title;
  final String image;
  final String description;

  Reservecar({
    required this.title,
    required this.image,
    required this.description,
  });
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


List<Tourismcompany> tourismcompanies = [
  Tourismcompany(
    title: "Happy Tour",
    image: "assets/images/tourism.png",
    description: "",
    rate: 2,
  ),
];

List<FlyingCompany> flyingcompanies = [
  FlyingCompany(
    title: "Egypyair",
    image: "assets/images/egyptair.png",
    description: "",
  ),
];

List<Reservecar> reservecars = [
  Reservecar(
    title: "Kia Cerato",
    image: "assets/images/kia.png",
    description: "",
  ),
];

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
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child:  InfoCard(),
    ),
  );
}
