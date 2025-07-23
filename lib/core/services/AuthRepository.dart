// // lib/core/repositories/auth_repository.dart

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:tripto/core/services/dio_client.dart'; // استخدم DioClient اللي عملناه

// class AuthRepository {
//   final DioClient _dioClient;
//   final FlutterSecureStorage _storage;

//   AuthRepository({
//     required DioClient dioClient,
//     required FlutterSecureStorage storage,
//   }) : _dioClient = dioClient,
//        _storage = storage;

//   // دالة للتسجيل
//   Future<Map<String, dynamic>> register({
//     required String name,
//     required String email,
//     required String phone,
//     required String password,
//     required String passwordConfirmation,
//   }) async {
//     try {
//       final response = await _dioClient.post(
//         'register',
//         data: {
//           'name': name,
//           'email': email,
//           'phone': phone,
//           'password': password,
//           'password_confirmation': passwordConfirmation,
//         },
//       );
//       // لو التسجيل نجح، احفظ التوكن
//       if (response.data['token'] != null) {
//         await _storage.write(key: 'jwt_token', value: response.data['token']);
//       }
//       return response.data; // رجّع بيانات الاستجابة
//     } catch (e) {
//       rethrow; // ارمِ الخطأ تاني عشان الـ BLoC يتعامل معاه
//     }
//   }

//   // دالة لإرسال الرقم لتلقي رمز التحقق (لصفحة الـ Login/Verification)
//   Future<Map<String, dynamic>> sendPhoneNumberForVerification({
//     required String phone,
//   }) async {
//     try {
//       // Endpoint هنا لازم يكون الخاص بإرسال كود التحقق
//       // افترض انه 'login' أو 'send-otp' بناءً على الـ Backend
//       final response = await _dioClient.post(
//         'login', // <--- تأكد من هذا الـ endpoint في الـ Backend
//         data: {'phone': phone},
//       );
//       // لو الـ Login API ده بيرجع Token (لو كان عملية Login كاملة)
//       if (response.data['token'] != null) {
//         await _storage.write(key: 'jwt_token', value: response.data['token']);
//       }
//       return response.data;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   // دالة لقراءة التوكن
//   Future<String?> getToken() async {
//     return await _storage.read(key: 'jwt_token');
//   }

//   // دالة لحذف التوكن عند تسجيل الخروج
//   Future<void> deleteToken() async {
//     await _storage.delete(key: 'jwt_token');
//   }

//   // ممكن تضيف دوال أخرى هنا للتحقق من الـ OTP، تسجيل الدخول، إلخ.
// }
