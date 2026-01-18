import 'package:equatable/equatable.dart';

abstract class ContactUsState extends Equatable {
  const ContactUsState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ContactInitial extends ContactUsState {}

class ContactLoading extends ContactUsState {}

class ContactFailure extends ContactUsState {
  final String error;
  const ContactFailure(String string, {required this.error});
  @override
  List<Object?> get props => [error];
}

class ContactSuccess extends ContactUsState {
  final String message;
  const ContactSuccess({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

// /////////////////////////////////////////////////////////////
class ReportInitial extends ContactUsState {}

class ReportLoading extends ContactUsState {}

class ReportFailure extends ContactUsState {
  final String error;
  const ReportFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

// class ReportSuccess extends ContactUsState {
//   final String message;
//   const ReportSuccess({required this.message});

//   @override
//   List<Object?> get props => [message];
// }
