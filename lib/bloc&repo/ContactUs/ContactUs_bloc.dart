import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/ContactUs/ContactIs_state.dart';
import 'package:tripto/bloc&repo/ContactUs/ContactUs_Event.dart';
import 'package:tripto/bloc&repo/ContactUs/ContactUs_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tripto/core/models/ContactUs_Model.dart';

class ContactusBloc extends Bloc<ContactusEvent, ContactUsState> {
  final ContactusRepository contactusRepository;

  ContactusBloc({required this.contactusRepository}) : super(ContactInitial()) {
    on<SubmitContactUs>(_onSubmitContactUs);
    // on<SubmitReport>(_onSubmitReport);
  }

  Future<void> _onSubmitContactUs(
    SubmitContactUs event,
    Emitter<ContactUsState> emit,
  ) async {
    emit(ContactLoading());
    try {
      ContactusModel model;

      if (event.pagetype == "report") {
        // قراءة البيانات المحفوظة
        final secureStorage = FlutterSecureStorage();
        final name = await secureStorage.read(key: 'name') ?? '';
        final email = await secureStorage.read(key: 'email') ?? '';
        final phone = await secureStorage.read(key: 'phone') ?? '';
        model = ContactusModel(
          name: name,
          email: email,
          phone: phone,
          messagebody: event.contactusModel.messagebody,
          subject: event.contactusModel.subject,
        );
      } else {
        // استخدام البيانات اللي جاية من الفورم
        model = event.contactusModel;
      }

      await contactusRepository.CreateMessage(model);
      emit(ContactSuccess(message: "Message sent successfully"));
    } catch (e) {
      emit(ContactFailure(e.toString(), error: 'Failed to send message'));
    }
  }
}
