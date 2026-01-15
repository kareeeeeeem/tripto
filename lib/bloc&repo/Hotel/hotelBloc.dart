import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/Hotel/hotelEvents.dart';
import 'package:tripto/bloc&repo/Hotel/hotelRep.dart';
import 'package:tripto/bloc&repo/Hotel/hotelStates.dart';

class HotelsBloc extends Bloc<HotelsEvent, HotelsState> {
  final HotelsRepository hotelsRepository;

  HotelsBloc({
    required this.hotelsRepository,
    // required HotelsRepository repository,
  }) : super(HotelsInitial()) {
    on<FetchAllHotels>(_onFetchAllHotels);

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
  Future<void> _onFetchAllHotels(
    FetchAllHotels event,
    Emitter<HotelsState> emit,
  ) async {
    emit(HotelsLoading());
    try {
      final Hotel = await hotelsRepository.FetchAllHotels();
      emit(GetAllHotelsSuccess(hotels: Hotel));
    } catch (e) {
      emit(HotelsError(message: 'No Internet connection'));
    }
  }
}
