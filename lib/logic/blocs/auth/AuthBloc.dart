import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:tripto/data/repositories/UserRepository.dart';
import 'package:tripto/logic/blocs/auth/AuthEvent.dart';
import 'package:tripto/logic/blocs/auth/AuthState.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final String _userKey = 'user_data';
  final String _tokenKey = 'token';

  AuthBloc({required this.userRepository}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    // on<FetchActivities>(_onFetchActivities);

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

      final token = response['token'];
      final user = response['user'];

      await _storage.write(key: _tokenKey, value: token);
      await _storage.write(
        key: 'user_data',
        value: jsonEncode(response['user']),
      );

      print('📦 RegisterRequested Saved token: $token');
      print('👤 RegisterRequested Saved user: $user');

      emit(
        RegisterSuccess(
          message: response['message_en'] ?? 'Register successful!',
          token: token,
          user: user,
        ),
      );
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await userRepository.loginUser(
        event.phoneNumber,
        event.password,
      );

      final token = response['token'];
      final user = response['user'];

      await _storage.write(key: _tokenKey, value: token);
      await _storage.write(key: _userKey, value: jsonEncode(user));

      print('📦 LoginRequested Saved token: $token');
      print('👤 LoginRequested Saved user: $user');

      emit(
        LoginSuccess(
          message: response['message_en'] ?? 'Login successful!',
          token: token,
          user: user,
        ),
      );
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }
  // Future<void> _onFetchActivities (
  //     FetchActivities event ,
  //     Emitter <AuthState> emit ,
  //     )async {
  //    emit(AuthLoading());
  //    try {
  //      final activities = await userRepository.getActivities();
  //      emit(AuthLoading(activities));
  //    } catch (e) {
  //      emit(AuthFailure(error: e.toString()));
  //    }
  //    }
  }
