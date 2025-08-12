import 'package:equatable/equatable.dart';
import 'package:tripto/bloc/%D9%90Auth/AuthEvent.dart';
import 'package:tripto/core/models/activityPageModel.dart';

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

class RegisterSuccess extends AuthState {
  final String message, token;
  final Map<String, dynamic> user;
  const RegisterSuccess({
    required this.message,
    required this.token,
    required this.user,
  });
  @override
  List<Object?> get props => [message, token, user];
}

class LoginSuccess extends AuthState {
  final String message, token;
  final Map<String, dynamic> user;
  const LoginSuccess({
    required this.message,
    required this.token,
    required this.user,
  });
  @override
  List<Object?> get props => [message, token, user];
}

// Get All Activites
class GetAllActivitiesSuccess extends AuthState {
  final List<GetActivityModel> activities;
  const GetAllActivitiesSuccess({required this.activities});

  @override
  List<Object?> get props => [activities];
}
