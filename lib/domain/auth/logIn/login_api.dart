import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../dto/login_dto.dart';

class LoginApi {
  static Future<Map<String, dynamic>> login(LoginDto loginDto) async {
    final url = Uri.parse('http://localhost:8081/v1/auth/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(loginDto.toJson()),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // 로그인 성공 시 응답
    } else {
      throw Exception('로그인 실패: ${response.statusCode}');
    }
  }

  // 로그아웃 메서드
  static Future<void> logout(String authToken) async {
    final url = Uri.parse('http://localhost:8081/v1/auth/logout');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken', // 인증 토큰 추가
      },
    );

    if (response.statusCode == 200) {
      print("로그아웃 성공");
    } else {
      throw Exception('로그아웃 실패: ${response.statusCode}');
    }
  }
}
