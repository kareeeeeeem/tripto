// lib/core/web_reloader.dart
import 'reloader_stub.dart' if (dart.library.html) 'reloader_web.dart'; 

abstract class WebReloader {
  void reload();
}

// 💡 هنا سيتم الاستيراد الشرطي.
// يجب أن يكون هذا الملف هو الوحيد الذي تستخدمه في VedioPlayerPage.dart

WebReloader getReloader() => getReloaderImplementation();