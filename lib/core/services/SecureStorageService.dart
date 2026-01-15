// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class SecureStorageService {
//   final FlutterSecureStorage _storage = const FlutterSecureStorage();

//   // ==== Token ====
//   Future<void> saveToken(String token) async {
//     await _storage.write(key: 'token', value: token);
//   }

//   Future<String?> getToken() async {
//     return await _storage.read(key: 'token');
//   }

//   Future<void> deleteToken() async {
//     await _storage.delete(key: 'token');
//   }

//   // ==== User Data ====
//   Future<void> saveUser(String userJson) async {
//     await _storage.write(key: 'user_data', value: userJson);
//   }

//   Future<Map<String, dynamic>?> getUser() async {
//     final userData = await _storage.read(key: 'user_data');
//     if (userData != null) {
//       return jsonDecode(userData);
//     }
//     return null;
//   }
           
//   Future<void> deleteUser() async {
//     await _storage.delete(key: 'user_data');
//   }

//   // ==== Clear All ====
//   Future<void> clearAll() async {
//     await _storage.deleteAll();
//   }
// }
