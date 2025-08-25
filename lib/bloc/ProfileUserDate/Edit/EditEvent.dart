import 'package:equatable/equatable.dart';

abstract class UpdateUserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateUserRequested extends UpdateUserEvent {
  final int id;
  final String name;
  final String email;
  final String phone;

  UpdateUserRequested({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  List<Object?> get props => [id, name, email, phone];
}
