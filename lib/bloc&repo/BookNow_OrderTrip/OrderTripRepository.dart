import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OrderTripRepository {
  final String baseUrl = "https://tripto.blueboxpet.com/api";
  final storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> createOrderTrip(Map<String, dynamic> data) async {
    final token = await storage.read(key: 'token');

    final response = await http.post(
      Uri.parse('$baseUrl/order-trips'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to create order: ${response.body}");
    }
  }
}
