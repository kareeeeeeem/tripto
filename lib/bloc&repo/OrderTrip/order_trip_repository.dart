import 'dart:convert';
import 'package:http/http.dart' as http;
import 'order_trip_model.dart';

class OrderTripSearcMyTripsRepository {
  final String baseUrl = "https://tripto.blueboxpet.com/api";

  Future<List<OrderTripSearcMyTrips>> fetchUserTrips(int? userId) async {
    if (userId == null) {
      throw Exception("User not logged in"); // ✨ لو مفيش يوزر
    }

    final url = Uri.parse('$baseUrl/order-trips/user?user_id=$userId');
    print("🔗 Request URL: $url");

    final response = await http.get(url);

    print("📡 Response Status: ${response.statusCode}");
    print("📦 Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => OrderTripSearcMyTrips.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch trips");
    }
  }
}
