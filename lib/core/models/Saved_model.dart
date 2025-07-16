class Activitysaved {
  final String imagePath;
  final String country;
  final String city;
  final String description;
  final String tabType;

  const Activitysaved({
    required this.imagePath,
    required this.country,
    required this.city,
    required this.description,
    required this.tabType,
  });
}

final List<Activitysaved> favoriteActivities = [
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
    country: "Italy",
    city: "Rome",
    description: "Another activity example in Italy.",
    tabType: "saved",
  ),
];
