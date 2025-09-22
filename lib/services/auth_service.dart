import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl =
      'http://localhost:8000/api'; // Replace with your API URL

  Future<bool> login(String nip, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': nip, 'password': password}),
      );
      // print('login. Kode status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Berhasil login! Respons API: $data'); // Tambahkan baris ini
        final token =
            data['data']['token']; // Adjust based on your API response
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        print("auth servcie mengembalikan true");
        return true;
      } else {
        return false;
      }
      // print(
      //   'Gagal login. Kode status: ${response.statusCode}',
      // );
      // print('Isi respons: ${response.body}'); // Tambahkan baris ini
    } catch (e) {
      return false;
    }
  }
}
