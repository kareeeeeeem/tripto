import 'package:equatable/equatable.dart';
import 'package:tripto/core/models/HomeApiModel.dart';

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
  final String message;
  final String token;
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
  final String message;
  final String token;
  final Map<String, dynamic> user;

  const LoginSuccess({
    required this.message,
    required this.token,
    required this.user,
  });

  @override
  List<Object?> get props => [message];
}

abstract class HomeApiModelState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeApiModelInitial extends HomeApiModelState {}

class HomeApiModelLoading extends HomeApiModelState {}

class HomeApiModelLoaded extends HomeApiModelState {
  final HomeApiModel homeData;

  HomeApiModelLoaded(this.homeData);
}

class HomeApiModelError extends HomeApiModelState {
  final String message;

  HomeApiModelError(this.message);
}








// class FetchActivities extends AuthState{
//   final String message ;
//
//   const FetchActivities({required this.message});
//
// }




// class OtpVerifiedSuccess extends AuthState {
//   final String message;

//   const OtpVerifiedSuccess({required this.message});

//   @override
//   List<Object?> get props => [message];
// }
