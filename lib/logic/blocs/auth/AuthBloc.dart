import 'package:bloc/bloc.dart';
import 'package:tripto/data/repositories/UserRepository.dart';
import 'package:tripto/logic/blocs/auth/AuthEvent.dart';
import 'package:tripto/logic/blocs/auth/AuthState.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthBloc({required this.userRepository}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<VerifyOtpRequested>(_onVerifyOtpRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final phoneNumber;

      print('📞 رقم الهاتف بعد الإضافة: $event.phoneNumber');
      print('🔐 كلمة المرور: ${event.password}');

      final response = await userRepository.loginUser(
        event.phoneNumber,
        event.password,
      );
      emit(LoginSuccess(message: response['message_en'] ?? ' Succeessful!'));
      print(response);
      await _storage.write(key: 'token', value: response['token']);
      String? token = await _storage.read(key: 'token');
      print('التوكين: $token');
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await userRepository.registerUser(
        event.name,
        event.email,
        event.phoneNumber,
        event.password,
        event.confirmPassword,
      );
      emit(RegisterSuccess(message: response['message'] ?? 'done!'));
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onVerifyOtpRequested(
    VerifyOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await userRepository.verifyOtp(
        event.phoneNumber,
        event.otpCode,
      );
      emit(
        OtpVerifiedSuccess(
          message: response['message'] ?? 'تم التحقق من الكود بنجاح!',
        ),
      );
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }
}
