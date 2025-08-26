import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc/Hotel/hotelEvents.dart';
import 'package:tripto/bloc/Hotel/hotelRep.dart';
import 'package:tripto/bloc/Hotel/hotelStates.dart';

class HotelsBloc extends Bloc<HotelsEvent, HotelsState> {
  final HotelsRepository hotelsRepository;

  HotelsBloc({required this.hotelsRepository}) : super(HotelsInitial()) {
    on<FetchHotels>((event, emit) async {
      emit(HotelsLoading());
      try {
        final hotels = await hotelsRepository.fetchHotels(
          event.subDestinationId,
        );

        print("Hotels fetched: ${hotels.length}");
        for (var h in hotels) {
          print("${h.nameEn} - ${h.subDestinationId}");
        }

        emit(HotelsLoaded(hotels: hotels));
      } catch (e) {
        emit(HotelsError(message: 'No Internet connection'));
      }
    });
  }
}
