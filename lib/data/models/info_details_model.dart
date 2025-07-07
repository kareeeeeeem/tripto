import 'package:flutter/material.dart';

class InfoDetailsModel extends StatefulWidget {
  const InfoDetailsModel({super.key});

  @override
  State<InfoDetailsModel> createState() => _InfoDetailsModelState();
}

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

class _InfoDetailsModelState extends State<InfoDetailsModel> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tourism Company Section
                Text(
                  "Tourism Company",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/images/tourism.png",
                        width: 100,
                        height: 50,
                        fit: BoxFit.fill,
                      ),
                    ),

                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tourismcompanies[0].title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            tourismcompanies[0].description,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(thickness: 1, color: Colors.grey),

                const SizedBox(height: 16),

                // Flying Company Section
                Text(
                  "Flying Company",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/images/egyptair.png",
                        width: 100,
                        height: 50,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            flyingcompanies[0].title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "This is the description of the company.This is the description of the companyThis is the description of the company",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(thickness: 1, color: Colors.grey),

                const SizedBox(height: 16),

                Text(
                  "Reserve a Car",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/images/kia.png",
                        width: 100,
                        height: 50,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reservecars[0].title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "This is the description of the company.This is the description of the companyThis is the description of the company",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(thickness: 1, color: Colors.grey),

                const SizedBox(height: 16),
                Text(
                  "Booking Hotels",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/images/hilton.png",
                        width: 100,
                        height: 50,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bookinghotels[0].title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "This is the description of the company.This is the description of the companyThis is the description of the company",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Buttons
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: const Color(0xFF001C36),
                      ),
                      child: const Text(
                        "Next",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 55),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: const Color(0xFF2196F3),
                      ),
                      child: const Text(
                        "Custom Trip",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void openbottomsheet(BuildContext context) {
  showDialog(
    context: context,
    builder:
        (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: InfoDetailsModel(),
        ),
  );
}
