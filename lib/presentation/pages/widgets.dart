// import 'package:flutter/material.dart';
// import '../../main.dart'; // علشان تقدر تستخدم TripToApp.setLocale()

// class LanguageTile extends StatefulWidget {
//   const LanguageTile({super.key});

//   @override
//   State<LanguageTile> createState() => _LanguageTileState();
// }

// class _LanguageTileState extends State<LanguageTile> {
//   void _toggleLanguage(BuildContext context) {
//     final currentLocale = Localizations.localeOf(context).languageCode;
//     final newLocale =
//         currentLocale == 'ar' ? const Locale('en') : const Locale('ar');

//     TripToApp.setLocale(context, newLocale);
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isEnglish = Localizations.localeOf(context).languageCode == 'en';

//     return ListTile(
//       leading: const Icon(Icons.language, color: Colors.white, size: 12),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             isEnglish ? "Change Language" : "تغيير اللغة",
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           Row(
//             children: [
//               TextButton(
//                 onPressed: () => _toggleLanguage(context),
//                 child: Text(
//                   isEnglish ? "العربية" : "English",
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               IconButton(
//                 onPressed: () => _toggleLanguage(context),
//                 icon: Icon(
//                   isEnglish
//                       ? Icons.keyboard_arrow_right_outlined
//                       : Icons.keyboard_arrow_left_outlined,
//                   size: 22,
//                   color: theme.iconTheme.color,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
