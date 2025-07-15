import 'package:flutter/material.dart';
// تأكد من استيراد المسارات الصحيحة بناءً على هيكل مشروعك
import 'package:tripto/core/routes/app_routes.dart';
import 'package:tripto/presentation/app/app.dart'; // افترض أن هذا هو مسار شاشة App الرئيسية
import 'package:tripto/core/constants/colors.dart'; // افترض أن هذا هو مسار ملف الألوان الخاص بك

// نموذج البيانات الخاص بك: ActivitiesCardmodel
class ActivitiesCardmodel {
  final String title;
  final String image; // تم تغييرها إلى image لتتوافق مع التصميم
  final double price;
  final int number;
  final int duration;
  final double rate;

  ActivitiesCardmodel({
    required this.title,
    required this.image,
    required this.price,
    required this.number,
    required this.duration,
    required this.rate,
  });
}

// قائمة الأنشطة التجريبية باستخدام ActivitiesCardmodel
List<ActivitiesCardmodel> exmactivities = [
  ActivitiesCardmodel(
    title: "Egyptian Museum",
    image: "assets/images/museum.png",
    price: 55,
    number: 1,
    duration: 50,
    rate: 1,
  ),
  ActivitiesCardmodel(
    title: "Pyramids Tour",
    image: "assets/images/pyramids.png",
    price: 70,
    number: 1,
    duration: 90,
    rate: 4.5,
  ),
  ActivitiesCardmodel(
    title: "Nile Cruise",
    image: "assets/images/nile_boat.png",
    price: 120,
    number: 1,
    duration: 180,
    rate: 4.8,
  ),
  ActivitiesCardmodel(
    title: "Khan el-Khalili Bazaar",
    image: "assets/images/bazaar.png",
    price: 30,
    number: 1,
    duration: 60,
    rate: 4.2,
  ),
  ActivitiesCardmodel(
    title: "Citadel of Salah al-Din",
    image: "assets/images/citadel.png",
    price: 45,
    number: 1,
    duration: 75,
    rate: 4.6,
  ),
  ActivitiesCardmodel(
    title: "Coptic Cairo",
    image: "assets/images/coptic.png",
    price: 25,
    number: 1,
    duration: 40,
    rate: 4.0,
  ),
  ActivitiesCardmodel(
    title: "Sound and Light Show",
    image: "assets/images/sound_light.png",
    price: 60,
    number: 1,
    duration: 50,
    rate: 4.3,
  ),
];

// **ملاحظة: btn_background_color_gradiant**
// هذا اللون يجب أن يكون معرفًا في ملف colors.dart الخاص بك،
// كما هو الحال في الكود الأصلي الذي أظهرته.
// لغرض هذا المثال، سأفترض وجوده أو استخدم لونًا مؤقتًا.
// const Color btn_background_color_gradiant = Colors.blue; // فقط كمثال إذا لم يكن معرفًا بالفعل

// ودجت بطاقة النشاط: ActivityCard
class ActivityCard extends StatelessWidget {
  final ActivitiesCardmodel activity; // استخدام ActivitiesCardmodel هنا

  const ActivityCard({required this.activity, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10), // نفس الهامش في التصميم الأصلي
      child: GestureDetector(
        onTap: () {
          // هنا تحتاج لتمرير ActivitiesCardmodel إلى صفحة التفاصيل
          Navigator.pushNamed(
            context,
            AppRoutes.activityDetailsPageRoute,
            arguments: activity, // تمرير كائن النشاط بالكامل
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox(
            height: 136,
            // العرض 130 في الكود الأصلي قد يكون ضيقاً جداً، ولكن للحفاظ على التصميم:
            // width: 130, // إذا تسبب هذا في overflow، قم بإزالته أو تعديله
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: double.infinity, // تملأ الارتفاع المتاح
                      width: 100, // عرض الصورة كما في التصميم الأصلي
                      child: Image.asset(
                        activity
                            .image, // استخدام مسار الصورة من ActivitiesCardmodel
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.error, color: Colors.red),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ), // مسافة كبيرة كما في التصميم الأصلي
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          activity.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2, // لضمان عدم تجاوز النص
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Price: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const TextSpan(
                                text: '\$',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '${activity.price.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // يمكنك إضافة Text('Number: ${activity.number}') هنا إذا أردت عرضه
                      ],
                    ),
                  ),
                  // العمود الأيمن (التقييم، المدة، أيقونة السيارة، زر الحجز)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(' ⭐ ${activity.rate} '),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.0001,
                          ),
                          Text('For: ${activity.duration} min'),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.001,
                          ),
                          const Icon(
                            Icons.directions_car_filled_sharp,
                            size: 20,
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(
                            110,
                            37,
                          ), // الحجم من التصميم الأصلي
                          backgroundColor:
                              btn_background_color_gradiant, // استخدم اللون الخاص بك
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.paymentOption);
                        },
                        child: const Text(
                          'Book',
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
      ),
    );
  }
}

// شاشة الأنشطة: Activities
class Activities extends StatelessWidget {
  const Activities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Activities",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            // العودة إلى شاشة App وإزالة جميع المسارات السابقة
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const App(), // العودة إلى App
              ),
              (Route<dynamic> route) => false, // إزالة جميع المسارات السابقة
            );
          },
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(
          bottom:
              MediaQuery.of(context).size.height *
              0.12, // تقريبًا 12% من الشاشة
        ),
        itemCount: exmactivities.length, // استخدام قائمة exmactivities المعرفة
        itemBuilder: (context, index) {
          final activity = exmactivities[index];
          return ActivityCard(
            activity: activity,
          ); // استخدام ActivityCard مع ActivitiesCardmodel
        },
      ),
    );
  }
}

void openActivitiesCard(BuildContext context, ActivitiesCardmodel activity) {
  showDialog(
    context: context,
    builder:
        (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ActivityCard(activity: activity),
        ),
  );
}
