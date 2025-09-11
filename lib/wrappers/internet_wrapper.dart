import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tripto/presentation/pages/No%20internet.dart';

class Wrapper extends StatefulWidget {
  final Widget child;
  const Wrapper({required this.child, Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool hasInternet = true;

  @override
  void initState() {
    super.initState();
    // نسمع حالة الإنترنت باستمرار
    InternetConnectionChecker.createInstance().onStatusChange.listen((status) {
      setState(() {
        hasInternet = status == InternetConnectionStatus.connected;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child, // التطبيق الأصلي
        if (!hasInternet)
          Positioned.fill(
            child: NoInternetPage(), // بتظهر كطبقة فوق كل حاجة
          ),
      ],
    );
  }
}
