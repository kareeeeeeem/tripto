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
  final String pagetype;

  const SubmitContactUs({required this.contactusModel, required this.pagetype});

  @override
  List<Object?> get props => [contactusModel];
}

// class SubmitReport extends ContactusEvent{
//   final String subject ;
//   final String message ;

//   SubmitReport({required this.message , required this.subject});
//   @override
//   // TODO: implement props
//   List<Object?> get props => [subject,message];
// }
