import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tripto/bloc&repo/GetTrip/GetTrip_model.dart';

class SearchTripByDateRepository {
  Future<List<GetTripModel>> fetchTripsByDate(DateTime from, DateTime to) async {
    final url = Uri.parse('https://tripto.blueboxpet.com/api/trips');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // ✅ تحقق إن البيانات تحتوي على رحلات
      if (data is Map && data.containsKey('trips')) {
        final trips = (data['trips'] as List)
            .map((tripJson) => GetTripModel.fromJson(tripJson))
            .toList();

        // ✅ فلترة الرحلات بناءً على تداخل التواريخ
        final filteredTrips = trips.where((trip) {
          try {
            final fromDates = List<String>.from(trip.fromDate ?? []);
            final toDates = List<String>.from(trip.toDate ?? []);

            for (int i = 0; i < fromDates.length; i++) {
              final tripFrom = DateTime.parse(fromDates[i]);
              final tripTo = DateTime.parse(toDates[i]);

              // ✅ تحقق من التداخل بين المدى الزمني المختار ومدى الرحلة
              final overlap = from.isBefore(tripTo) && to.isAfter(tripFrom);
              if (overlap) return true;
            }
          } catch (e) {
            print('Date parse error: $e');
          }
          return false;
        }).toList();

        return filteredTrips;
      } else {
        throw Exception('Invalid response structure');
      }
    } else {
      throw Exception('Failed to fetch trips: ${response.statusCode}');
    }
  }
}
