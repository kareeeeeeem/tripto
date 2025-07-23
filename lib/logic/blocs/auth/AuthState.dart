import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class LoginSuccess extends AuthState {
  final String message;

  const LoginSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class RegisterSuccess extends AuthState {
  final String message;

  const RegisterSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class OtpVerifiedSuccess extends AuthState {
  final String message;

  const OtpVerifiedSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}
