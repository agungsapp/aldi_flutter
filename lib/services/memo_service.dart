import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MemoService {
  static const String baseUrl = 'http://localhost:8000/api';

  Future<List<dynamic>> getMemos() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) throw Exception('Token tidak ditemukan');

    final response = await http.get(
      Uri.parse('$baseUrl/memo'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']; // <- ini adalah list memo
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized - token expired');
    } else {
      throw Exception('Gagal mengambil data memo (${response.statusCode})');
    }
  }
}
