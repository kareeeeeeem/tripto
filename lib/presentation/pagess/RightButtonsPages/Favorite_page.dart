import 'package:flutter/material.dart';
import 'package:tripto/core/constants/Expanded_text.dart';
import '../../../data/models/Saved_model.dart';
import '../payment_option.dart';

class Saved_History extends StatefulWidget {
  const Saved_History({super.key});

  @override
  State<Saved_History> createState() => _Saved_HistoryState();
}

class _Saved_HistoryState extends State<Saved_History>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // بيانات تجريبية علشان تعرض الكروت
  final List<Activitysaved> savedActivities = [
    Activitysaved(
      imagePath: "assets/images/museum.png",
      country: "Egypt",
      city: "Cairo",
      description: "This is a dummy activity used just to preview the UI structure.",
      tabType: "saved",
    ),
    Activitysaved(
      imagePath: "assets/images/museum.png",
      country: "Egypt",
      city: "Aswan",
      description: "Visit the beautiful temples and enjoy the Nile.",
      tabType: "saved",
    ),
    Activitysaved(
      imagePath: "assets/images/museum.png",
      country: "Egypt",
      city: "Aswan",
      description: "Visit the beautiful temples and enjoy the Nile.",
      tabType: "saved",
    ),
    Activitysaved(
      imagePath: "assets/images/museum.png",
      country: "Egypt",
      city: "Aswan",
      description: "Visit the beautiful temples and enjoy the Nile.",
      tabType: "saved",
    ),
    Activitysaved(
      imagePath: "assets/images/museum.png",
      country: "Egypt",
      city: "Aswan",
      description: "Visit the beautiful temples and enjoy the Nile.",
      tabType: "saved",
    ),
    Activitysaved(
      imagePath: "assets/images/museum.png",
      country: "Egypt",
      city: "Aswan",
      description: "Visit the beautiful temples and enjoy the Nile.",
      tabType: "saved",
    ),
  ];

  final List<Activitysaved> historyActivities = [
    Activitysaved(
      imagePath: "assets/images/museum.png",
      country: "Egypt",
      city: "Alexandria",
      description: "This is a dummy history activity for UI testing.",
      tabType: "history",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Row(
                children: [
                  Icon(Icons.favorite, color: Colors.black),
                  Text("Saved"),
                  SizedBox(width: 10),
                ],
              ),
            ),
            Tab(
              child: Row(
                children: [
                  Icon(Icons.history, color: Colors.black),
                  Text("History"),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFavoriteList(savedActivities),
          _buildFavoriteList(historyActivities),
        ],
      ),
    );
  }

  Widget _buildFavoriteList(List<Activitysaved> favoriteActivities) {
    return ListView.builder(
      itemCount: favoriteActivities.length,
      itemBuilder: (context, index) {
        final activity = favoriteActivities[index];
        return Card(
          child: Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.25,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 46),
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    image: DecorationImage(
                      image: AssetImage(activity.imagePath),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(activity.country,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 6),
                      Text(activity.city,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 6),
                      ExpandedText(
                        text: activity.description,
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentOption()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(activity.tabType == "saved"
                              ? "Book"
                              : "Rebook"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
