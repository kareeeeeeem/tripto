import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/%D9%90Auth/AuthRepository.dart';
import 'LogoutEvent.dart';
import 'LogoutState.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRepository repository;

  LogoutBloc({required this.repository}) : super(LogoutInitial()) {
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<LogoutState> emit,
  ) async {
    emit(LogoutLoading());
    try {
      await repository.logout();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutFailure(e.toString()));
    }
  }
}
