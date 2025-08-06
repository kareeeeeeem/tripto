import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc/ِAuth/AuthEvent.dart';
import 'package:tripto/bloc/ِAuth/AuthState.dart';
import 'package:tripto/data/repositories/AuthRepository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<RegisterRequested>(_onRegisterRequested);
    on<LoginRequested>(_onLoginRequested);
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
      emit(
        RegisterSuccess(
          message: response['message'],
          token: response['token'],
          user: response['user'],
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
      final response = await authRepository.login(
        event.phoneNumber,
        event.password,
      );
      emit(
        LoginSuccess(
          message: response['message'],
          token: response['token'],
          user: response['user'],
        ),
      );
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }
}
