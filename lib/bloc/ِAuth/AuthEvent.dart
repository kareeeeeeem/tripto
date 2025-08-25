import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class RegisterRequested extends AuthEvent {
  final String name, email, phoneNumber, password, confirmPassword;

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
  final String phoneNumber, password;

  const LoginRequested({required this.phoneNumber, required this.password});
}

// get activities
class FetchAcvtivites extends AuthEvent {
  const FetchAcvtivites();

  @override
  List<Object?> get props => [];
}
