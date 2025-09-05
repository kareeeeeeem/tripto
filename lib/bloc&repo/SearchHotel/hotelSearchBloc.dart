import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tripto/bloc&repo/SearchHotel/hotelSearchEvents.dart';
import 'package:tripto/core/models/Hotels%D9%80model.dart';
import 'hotelSearchStates.dart';

class HotelsSearchBloc extends Bloc<HotelsSearchEvent, HotelsSearchState> {
  HotelsSearchBloc() : super(HotelsSearchInitial()) {
    on<SearchHotelsByName>((event, emit) async {
      emit(HotelsSearchLoading());
      try {
        final response = await http.get(
          Uri.parse(
              "https://tripto.blueboxpet.com/api/hotels/search?query=${event.query}"),
        );
        print("API Response: ${response.body}");


        if (response.statusCode == 200) {
          final List<dynamic> data = jsonDecode(response.body)["data"];
          final hotels = data.map((e) => HotelModel.fromJson(e)).toList();
          emit(HotelsSearchLoaded(hotels: hotels));
        } else {
          emit(HotelsSearchError(message: "Failed to search hotels"));
        }
      } catch (e) {
        emit(HotelsSearchError(message: e.toString()));
      }
    });
  }
}
