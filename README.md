# tripto

lib/
├── core/                      # أشياء عامة ومشتركة بين كل الموديولات
│   ├── constants/             # ألوان، صور، ثوابت
│   ├── error/                 # إدارة الأخطاء (Failure Classes)
│   ├── routes/                # إدارة المسارات (Navigation)
│   ├── services/             # أدوات مثل API client أو التخزين المحلي
│   ├── theme/                # الثيمات العامة (ألوان، خطوط، أزرار)
│   └── utils/                # أدوات مساعدة عامة
│
├── features/                  # كل ميزة لها مجلد مستقل
│   ├── splash/                # ميزة Splash فقط
│   │   ├── data/
│   │   │   ├── models/        # نماذج البيانات (SplashModel مثلًا)
│   │   │   └── datasources/   # لو فيه API أو local data
│   │   ├── domain/
│   │   │   ├── entities/      # الكيانات المجردة (Entity)
│   │   │   └── usecases/      # منطق التطبيق (UseCases)
│   │   ├── presentation/
│   │   │   ├── pages/         # الصفحات الرئيسية
│   │   │   ├── widgets/       # ودجتس مساعدة
│   │   │   └── controllers/   # Cubit / Bloc / Provider
│   │   └── splash.dart        # barrel file لتصدير كل شيء من الميزة
│   │
│   └── home/                  # ميزة أخرى مثل الصفحة الرئيسية
│       └── ...
│
├── injection/                 # ملف إعداد الـ Dependency Injection
│   └── service_locator.dart
│
├── main.dart                  # ملف البداية الرئيسي للتطبيق
