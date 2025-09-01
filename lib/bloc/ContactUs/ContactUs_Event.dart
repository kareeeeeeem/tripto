import 'package:equatable/equatable.dart';
import 'package:tripto/core/models/ContactUs_Model.dart';

abstract class ContactusEvent extends Equatable {
  const ContactusEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SubmitContactUs extends ContactusEvent {
  final ContactusModel contactusModel;

  const SubmitContactUs({required this.contactusModel});

  @override
  List<Object?> get props => [contactusModel];
}
