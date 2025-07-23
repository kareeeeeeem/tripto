// // lib/blocs/auth/auth_event.dart

// import 'package:equatable/equatable.dart';

// abstract class AuthEvent extends Equatable {
//   const AuthEvent();

//   @override
//   List<Object> get props => [];
// }

// class SignUpRequested extends AuthEvent {
//   final String name;
//   final String email;
//   final String phone;
//   final String password;
//   final String passwordConfirmation;

//   const SignUpRequested({
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.password,
//     required this.passwordConfirmation,
//   });

//   @override
//   List<Object> get props => [name, email, phone, password, passwordConfirmation];
// }

// class SendPhoneForVerificationRequested extends AuthEvent {
//   final String phone;

//   const SendPhoneForVerificationRequested({required this.phone});

//   @override
//   List<Object> get props => [phone];
// }

// // ممكن تضيف أحداث لـ Login, Logout, VerifyOtp, إلخ.
