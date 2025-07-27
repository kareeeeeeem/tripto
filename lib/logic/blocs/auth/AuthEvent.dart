import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;
  final String confirmPassword;

  const RegisterRequested({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [
    name,
    email,
    phoneNumber,
    password,
    confirmPassword,
  ];
}

class LoginRequested extends AuthEvent {
  final String phoneNumber;
  final String password;

  const LoginRequested({required this.phoneNumber, required this.password});

  @override
  List<Object?> get props => [phoneNumber, password];
}

class VerifyOtpRequested extends AuthEvent {
  final String phoneNumber;
  final String otpCode;

  const VerifyOtpRequested({required this.phoneNumber, required this.otpCode});

  @override
  List<Object?> get props => [phoneNumber, otpCode];
}
// class FetchActivities  extends AuthEvent {
//   const FetchActivities ();
//
//   @override
//   List<Object?> get props => [];
// }