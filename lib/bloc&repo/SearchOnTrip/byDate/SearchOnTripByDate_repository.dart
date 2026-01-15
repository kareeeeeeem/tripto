import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tripto/bloc&repo/GetTrip/GetTrip_model.dart';

class SearchTripByDateRepository {
  Future<List<GetTripModel>> fetchTripsByDate(DateTime from, DateTime to) async {
    print("📡 بدء جلب الرحلات من السيرفر...");

    final url = Uri.parse('https://tripto.blueboxpet.com/api/trips');
    final response = await http.get(url);
    print("🌐 كود الاستجابة: ${response.statusCode}");
    print("📦 نص الاستجابة: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // ✅ استخدم data مباشرة كقائمة
      final tripsJsonList = data as List;

      print("📦 تم جلب ${tripsJsonList.length} رحلة من السيرفر");

      final trips = tripsJsonList
          .map((tripJson) => GetTripModel.fromJson(tripJson))
          .toList();

      // ✅ فلترة الرحلات بناءً على النطاق الزمني المحدد
      final filteredTrips = trips.where((trip) {
        try {
          if (trip.fromDate.isEmpty || trip.toDate.isEmpty) return false;

          for (int i = 0; i < trip.fromDate.length; i++) {
            final startRaw = trip.fromDate[i];
            final endRaw = (i < trip.toDate.length)
                ? trip.toDate[i]
                : trip.fromDate[i]; // fallback لو القائمتين مش نفس الطول

            if (startRaw.isEmpty || endRaw.isEmpty) continue;

            final start = DateTime.tryParse(startRaw);
            final end = DateTime.tryParse(endRaw);

            if (start == null || end == null) continue;

            // ✅ أي تداخل بين النطاقين يعتبر مطابقة
            final overlaps = !(to.isBefore(start) || from.isAfter(end));
            if (overlaps) return true;
          }
        } catch (e) {
          print("❌ خطأ أثناء تحليل التواريخ للرحلة: $e");
        }
        return false;
      }).toList();

      print("✅ عدد الرحلات بعد الفلترة: ${filteredTrips.length}");
      for (var t in filteredTrips) {
        print("🟢 ${t.destinationNameEn} | ${t.fromDate} → ${t.toDate}");
      }

      return filteredTrips;
    } else {
      print("❌ فشل في جلب الرحلات من السيرفر، الكود: ${response.statusCode}");
      print("📦 نص الاستجابة: ${response.body}");
      throw Exception('فشل في جلب الرحلات من السيرفر');
    }
  }
}
