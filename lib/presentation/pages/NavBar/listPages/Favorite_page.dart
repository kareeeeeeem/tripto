import 'package:flutter/material.dart';
import 'package:tripto/core/constants/Expanded_text.dart';
import 'package:tripto/presentation/app/app.dart';
import 'package:tripto/presentation/pages/NavBar/listPages/SideMenu.dart';
import '../../../../core/models/Saved_model.dart';
import '../../screens/payment/payment_option.dart';
import 'package:tripto/l10n/app_localizations.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
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
      backgroundColor: Colors.white,
      appBar: AppBar(
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
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Color(0xFF002E70),
          labelColor: Color(0xFF002E70),
          unselectedLabelColor: Colors.black,
          tabs: [
            Tab(
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.favorite, color: Colors.black),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  Text(AppLocalizations.of(context)!.saved),
                ],
              ),
            ),
            Tab(
              child: Row(
                children: [
                  const Icon(Icons.history, color: Colors.black),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  Text(AppLocalizations.of(context)!.history),
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

        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
            height: MediaQuery.of(context).size.height * 0.26,
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
                            side: const BorderSide(
                              color: Color(0xFF002E70),
                              width: 2,
                            ),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.unsave,
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
                        activity.tabType == "saved"
                            ? AppLocalizations.of(context)!.book
                            : AppLocalizations.of(context)!.rebook,
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
