lib/
├── data/                        # طبقة البيانات (Data Layer)
│   ├── models/                  # نماذج البيانات (Data Models)
│   ├── repositories/            # تنفيذ الـ Repositories
│   ├── sources/                 # مصادر البيانات (Remote وLocal)
│   │   ├── remote/              # API أو مصادر خارجية
│   │   └── local/               # قواعد بيانات محلية
│   └── services/                # خدمات إضافية (مثل Network أو Storage)
├── domain/                      # طبقة المنطق الأساسي (Domain Layer)
│   ├── entities/                # الكيانات (Entities)
│   ├── repositories/            # واجهات الـ Repositories (Abstract)
│   └── usecases/                # الـ Use Cases (Business Logic)
├── presentation/                # طبقة العرض (Presentation Layer)
│   ├── blocs/                   # الـ BLoC لإدارة الحالة
│   ├── pages/                   # الشاشات أو الصفحات
│   ├── widgets/                 # مكونات الـ UI القابلة لإعادة الاستخدام
│   └── routes/                  # إدارة التنقل بين الشاشات
├── core/                        # ملفات مشتركة (مثل الثوابت، Errors، Utilities)
│   ├── constants/               # الثوابت (مثل API URLs)
│   ├── errors/                  # إدارة الأخطاء
│   └── utilities/               # أدوات مساعدة (مثل Logger)
├── injection_container.dart     # إعداد Dependency Injection
└── main.dart                    # نقطة بداية التطبيق