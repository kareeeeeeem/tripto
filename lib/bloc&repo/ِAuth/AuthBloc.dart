import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tripto/bloc&repo/%D9%90Auth/AuthRepository.dart';
import 'package:tripto/bloc&repo/%D9%90Auth/AuthEvent.dart';
import 'package:tripto/bloc&repo/%D9%90Auth/AuthState.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<RegisterRequested>(_onRegisterRequested);
    on<LoginRequested>(_onLoginRequested);
    on<FetchAcvtivites>(_onFetchActivities);
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await authRepository.register(
        event.name,
        event.email,
        event.phoneNumber,
        event.password,
        event.confirmPassword,
      );

      if (response['error'] == true) {
        // جهز رسالة مفهومة للمستخدم
        String errorMessage = response['message'] ?? 'Registration failed';
        if (response['errors'] != null) {
          response['errors'].forEach((key, value) {
            if (value is List && value.isNotEmpty) {
              errorMessage += "\n$key: ${value.join(', ')}";
            }
          });
        }
        emit(AuthFailure(error: errorMessage));
      } else {
        await _storage.write(key: 'jwt_token', value: response['token']);
        await _storage.write(
          key: 'user_data',
          value: jsonEncode(response['user']),
        );

        emit(
          RegisterSuccess(
            message: response['message'] ?? 'Registration successful',
            token: response['token'],
            user: response['user'],
          ),
        );
      }
    } catch (e) {
      emit(AuthFailure(error: 'Registration failed: $e'));
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await authRepository.login(
        event.phoneNumber,
        event.password,
      );

      if (response['error'] == true) {
        String errorMessage = response['message'] ?? 'Login failed';
        if (response['errors'] != null) {
          response['errors'].forEach((key, value) {
            if (value is List && value.isNotEmpty) {
              errorMessage += "\n$key: ${value.join(', ')}";
            }
          });
        }
        emit(AuthFailure(error: errorMessage));
      } else {
        // تخزين التوكن وبيانات المستخدم بعد تسجيل الدخول
        await _storage.write(key: 'jwt_token', value: response['token']);
        await _storage.write(
          key: 'user_data',
          value: jsonEncode(response['user']),
        );

        emit(
          LoginSuccess(
            message: response['message_en'] ?? 'Login successful',
            token: response['token'],
            user: response['user'],
          ),
        );
      }
    } catch (e) {
      emit(AuthFailure(error: 'Login failed: ${e.toString()}'));
    }
  }

  Future<void> _onFetchActivities(
    FetchAcvtivites event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final Activities = await authRepository.getActivities();
      emit(GetAllActivitiesSuccess(activities: Activities));
    } catch (e) {
      emit(AuthFailure(error: 'No Internet connection'));
    }
  }
}
