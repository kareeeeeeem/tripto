import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tripto/core/services/api.dart';
import '../../../core/models/Hotelsـmodel.dart';

class HotelsRepository {
  final String baseUrl = "https://tripto.blueboxpet.com/api/hotels";

  Future<List<HotelModel>> fetchHotels(int subDestinationId) async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      // تصفية الفنادق حسب subDestinationId
      final filtered =
          data
              .where((e) => e['sub_destination_id'] == subDestinationId)
              .toList();
      return filtered.map((json) => HotelModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load hotels");
    }
  }

  Future<List<HotelModel>> FetchAllHotels() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}hotels'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      // ✅ رجّع كل الفنادق من غير فلترة
      return data.map((json) => HotelModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load hotels");
    }
  }
}
