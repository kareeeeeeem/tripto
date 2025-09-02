import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/ContactUs/ContactIs_state.dart';
import 'package:tripto/bloc&repo/ContactUs/ContactUs_Event.dart';
import 'package:tripto/bloc&repo/ContactUs/ContactUs_repository.dart';

class ContactusBloc extends Bloc<ContactusEvent, ContactUsState> {
  final ContactusRepository contactusRepository;

  ContactusBloc({required this.contactusRepository}) : super(ContactInitial()) {
    on<SubmitContactUs>(_onSubmitContactUs);
  }

  Future<void> _onSubmitContactUs(
    SubmitContactUs event,
    Emitter<ContactUsState> emit,
  ) async {
    emit(ContactLoading());
    try {
      await contactusRepository.CreateMessage(event.contactusModel);
      emit(ContactSuccess(message: "Message sent successfully"));
    } catch (e) {
      emit(ContactFailure(error: e.toString()));
    }
  }
}
