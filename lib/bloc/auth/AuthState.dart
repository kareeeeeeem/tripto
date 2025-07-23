// // lib/blocs/auth/auth_state.dart

// import 'package:equatable/equatable.dart';

// abstract class AuthState extends Equatable {
//   const AuthState();

//   @override
//   List<Object> get props => [];
// }

// class AuthInitial extends AuthState {}

// class AuthLoading extends AuthState {}

// class AuthSuccess extends AuthState {
//   final String message; // رسالة النجاح من الـ API

//   const AuthSuccess(this.message);

//   @override
//   List<Object> get props => [message];
// }

// class AuthFailure extends AuthState {
//   final String error; // رسالة الخطأ

//   const AuthFailure(this.error);

//   @override
//   List<Object> get props => [error];
// }
