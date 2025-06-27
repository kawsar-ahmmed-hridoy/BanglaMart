import 'dart:convert';
import 'package:http/http.dart' as http;

class BkashService {
  static const String baseUrl = 'http://your-server.com:3000';

  static Future<String> getToken() async {
    final response = await http.post(Uri.parse('$baseUrl/bkash-token'));
    return jsonDecode(response.body)['token'];
  }

  static Future<Map<String, dynamic>> createPayment(double amount, String invoice) async {
    final token = await getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/create-payment'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'amount': amount.toStringAsFixed(2), 'invoice': invoice}),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> executePayment(String paymentId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/execute-payment'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'paymentID': paymentId}),
    );
    return jsonDecode(response.body);
  }
}
