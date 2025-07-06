// import 'package:flutter/material.dart';
//
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});
//
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             "Profile",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       keyboardType: TextInputType.text,
//                       decoration: InputDecoration(
//                         labelText: "Name",
//                         labelStyle: TextStyle(color: Colors.grey , fontSize: 18),
//
//                         enabledBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey,
//                             width: 1,
//
//                           ),
//                         ),
//                       )
//                       textInputAction: TextInputAction.next,
//
//                     ),
//                   ),
//
//                   Text("Edit")
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
