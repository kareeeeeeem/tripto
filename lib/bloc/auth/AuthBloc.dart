// // lib/blocs/auth/auth_bloc.dart

// import 'package:bloc/bloc.dart';
// import 'package:tripto/bloc/auth/AuthEvent';
// import 'package:tripto/bloc/auth/AuthState.dart';
// import 'package:dio/dio.dart'; // عشان تتعامل مع DioException
// import 'package:tripto/core/services/AuthRepository.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthRepository _authRepository;

//   AuthBloc({required AuthRepository authRepository})
//     : _authRepository = authRepository,
//       super(AuthInitial()) {
//     // الحالة الأولية
//     on<SignUpRequested>(_onSignUpRequested);
//     on<SendPhoneForVerificationRequested>(_onSendPhoneForVerificationRequested);
//     // ... ضيف handler لأي أحداث تانية
//   }

//   Future<void> _onSignUpRequested(
//     SignUpRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     emit(AuthLoading()); // إصدار حالة التحميل
//     try {
//       final responseData = await _authRepository.register(
//         name: event.name,
//         email: event.email,
//         phone: event.phone,
//         password: event.password,
//         passwordConfirmation: event.passwordConfirmation,
//       );
//       emit(
//         AuthSuccess(responseData['message'] ?? 'Registration successful'),
//       ); // إصدار حالة النجاح
//     } on DioException catch (e) {
//       emit(
//         AuthFailure(
//           e.response?.data['message'] ?? e.message ?? 'Registration failed',
//         ),
//       ); // إصدار حالة الخطأ
//     } catch (e) {
//       emit(AuthFailure(e.toString()));
//     }
//   }

//   Future<void> _onSendPhoneForVerificationRequested(
//     SendPhoneForVerificationRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     emit(AuthLoading());
//     try {
//       final responseData = await _authRepository.sendPhoneNumberForVerification(
//         phone: event.phone,
//       );
//       emit(AuthSuccess(responseData['message'] ?? 'Verification code sent'));
//     } on DioException catch (e) {
//       emit(
//         AuthFailure(
//           e.response?.data['message'] ??
//               e.message ??
//               'Failed to send verification code',
//         ),
//       );
//     } catch (e) {
//       emit(AuthFailure(e.toString()));
//     }
//   }
// }
