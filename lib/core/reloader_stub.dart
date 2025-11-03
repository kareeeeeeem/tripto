// lib/core/reloader_stub.dart

import 'package:tripto/core/web_reloader.dart';

// 💡 هذا الكود يتم ترجمته للموبايل فقط (وهو لا يفعل شيئاً)
class WebReloaderStub implements WebReloader {
  @override
  void reload() {
    // لا تفعل شيئاً في بيئات غير الويب لتجنب الخطأ
    print("Web reload called on non-web platform. Ignored.");
  }
}

WebReloader getReloaderImplementation() => WebReloaderStub();