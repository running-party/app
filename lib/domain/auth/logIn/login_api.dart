import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../dto/login_dto.dart';

class LoginApi {
  static Future<Map<String, dynamic>> login(LoginDto loginDto) async {
    final url = Uri.parse('http://localhost:8081/v1/user/login');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(loginDto.toJson()),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);  // 로그인 성공 시 응답
    } else {
      throw Exception('로그인 실패: ${response.statusCode}');
    }
  }
}
