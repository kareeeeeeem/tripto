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
    const Activitysaved(
      imagePath: "assets/images/museum.png",
      country: "Egypt",
      city: "Cairo",
      description:
          "This is a dummy activity used just to preview the UI structure.",
      tabType: "saved",
    ),
    const Activitysaved(
      imagePath: "assets/images/museum.png",
      country: "Egypt",
      city: "Aswan",
      description: "Visit the beautiful temples and enjoy the Nile.",
      tabType: "saved",
    ),
    const Activitysaved(
      imagePath: "assets/images/museum.png",
      country: "Egypt",
      city: "Aswan",
      description: "Visit the beautiful temples and enjoy the Nile.",
      tabType: "saved",
    ),
    const Activitysaved(
      imagePath: "assets/images/museum.png",
      country: "Egypt",
      city: "Aswan",
      description: "Visit the beautiful temples and enjoy the Nile.",
      tabType: "saved",
    ),
    const Activitysaved(
      imagePath: "assets/images/museum.png",
      country: "Egypt",
      city: "Aswan",
      description: "Visit the beautiful temples and enjoy the Nile.",
      tabType: "saved",
    ),
    const Activitysaved(
      imagePath: "assets/images/museum.png",
      country: "Egypt",
      city: "Aswan",
      description: "Visit the beautiful temples and enjoy the Nile.",
      tabType: "saved",
    ),
  ];

  final List<Activitysaved> historyActivities = [
    const Activitysaved(
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
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.favorite, color: Colors.black),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  const Text("Saved"),
                ],
              ),
            ),
            Tab(
              child: Row(
                children: [
                  const Icon(Icons.history, color: Colors.black),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  const Text("History"),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.025),
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
      padding: EdgeInsets.only(
        bottom:
            MediaQuery.of(context).size.height * 0.12, // تقريبًا 12% من الشاشة
      ),
      itemCount: favoriteActivities.length,
      itemBuilder: (context, index) {
        final activity = favoriteActivities[index];
        // ... باقي الكود زي ما هو

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        image: DecorationImage(
                          image: AssetImage(activity.imagePath),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Padding(
                          //   padding: EdgeInsets.only(
                          //     top: MediaQuery.of(context).size.height * 0.1,
                          //   ),
                          //   child:
                          Text(
                            activity.country,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          // ),
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height * 0.009,
                          // ),
                          Text(
                            activity.city,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.009,
                          ),
                          ExpandedText(text: activity.description),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height:
                      MediaQuery.of(context).size.height *
                      0.015, // أو أي نسبة مناسبة ليك
                ),

                /// ✅ هنا الزرارين تحت الصورة والوصف، خارج Row الصورة
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (activity.tabType == "saved")
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          "Unsave",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else
                      const SizedBox(), // فراغ لو مش Saved

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaymentOption(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        activity.tabType == "saved" ? "Book" : "Rebook",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
