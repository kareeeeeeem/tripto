import 'package:equatable/equatable.dart';

abstract class LogoutEvent extends Equatable {
  const LogoutEvent();
  @override
  List<Object?> get props => [];
}

class LogoutRequested extends LogoutEvent {}

class DeleteAccountRequested extends LogoutEvent {
  final String token;
  const DeleteAccountRequested({required this.token});
  @override
  // TODO: implement props
  List<Object?> get props => [token];
}
