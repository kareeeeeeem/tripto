import 'package:equatable/equatable.dart';
import 'package:tripto/bloc/ProfileUserDate/Edit/EditModel.dart';

abstract class UpdateUserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateUserInitial extends UpdateUserState {}

class UpdateUserLoading extends UpdateUserState {}

class UpdateUserSuccess extends UpdateUserState {
  final User user;

  UpdateUserSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class UpdateUserFailure extends UpdateUserState {
  final String message;

  UpdateUserFailure(this.message);

  @override
  List<Object?> get props => [message];
}
