import 'package:flutter_bloc/flutter_bloc.dart';
import 'LogoutEvent.dart';
import 'LogoutState.dart';
import 'LogoutRepository.dart'; // هنا الـ AccountRepository
import 'dart:convert'; // لازم يكون موجود

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AccountRepository repository;

  LogoutBloc({required this.repository}) : super(LogoutInitial()) {
    on<LogoutRequested>(_onLogoutRequested);
  }
  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<LogoutState> emit,
  ) async {
    emit(LogoutLoading());
    try {
      final token = await repository.storage.read(key: 'jwt_token');
      if (token == null) throw Exception("No token found");

      final response = await repository.logoutRequest(token);

      if (response.statusCode == 200) {
        await repository.clearUserData(); // نحذف التوكن بعد نجاح اللوج أوت
        emit(LogoutSuccess());
      } else {
        // نحاول قراءة الرسالة من السيرفر
        String message = "Logout failed";
        try {
          final data = jsonDecode(response.body);
          message = data['message'] ?? message;
        } catch (_) {}
        emit(LogoutFailure(message));
      }
    } catch (e) {
      emit(LogoutFailure(e.toString()));
    }
  }
}
