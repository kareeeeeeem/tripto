// lib/core/reloader_web.dart

import 'dart:html' as html;
import 'package:tripto/core/web_reloader.dart';

// 💡 هذا الكود يتم ترجمته للويب فقط
class WebReloaderWeb implements WebReloader {
  @override
  void reload() {
    html.window.location.reload();
  }
}

WebReloader getReloaderImplementation() => WebReloaderWeb();