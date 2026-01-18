import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tripto/core/models/ContactUs_Model.dart';
import 'package:tripto/core/services/api.dart';

class ContactusRepository {
  Future<void> CreateMessage(ContactusModel contactusModel) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}contacts'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(contactusModel.toJson()),
    );
    print("Response status: ${response.statusCode}");
    print("Raw response body: ${response.body}");

    late final dynamic responseBody;
    try {
      responseBody = jsonDecode(response.body);
    } catch (e) {
      print("❌ JSON Decode Error: $e");
      throw Exception("❌ Server response is not JSON");
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("✅  Create Message Successfully");
      return;
    } else {
      throw Exception(
        "❌ Server Error: ${responseBody['message'] ?? 'Unknown'}",
      );
    }
  }
}
