import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc/ProfileUserDate/Edit/EditEvent.dart';
import 'package:tripto/bloc/ProfileUserDate/Edit/EditState.dart';
import 'package:tripto/bloc/Repositories/ProfileRepository.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final UserRepository userRepository;

  UpdateUserBloc({required this.userRepository}) : super(UpdateUserInitial()) {
    on<UpdateUserRequested>(_onUpdateUserRequested);
  }

  Future<void> _onUpdateUserRequested(
    UpdateUserRequested event,
    Emitter<UpdateUserState> emit,
  ) async {
    emit(UpdateUserLoading());
    try {
      final updatedUser = await userRepository.updateUser(
        id: event.id,
        name: event.name,
        email: event.email,
        phone: event.phone,
      );
      emit(UpdateUserSuccess(updatedUser));
    } catch (e) {
      emit(UpdateUserFailure(e.toString()));
    }
  }
}
