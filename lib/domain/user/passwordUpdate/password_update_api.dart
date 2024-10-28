// password_update_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../dto/password_update_dto.dart';

class PasswordUpdateApi {
  static Future<bool> updatePassword(PasswordUpdateDto dto) async {
    final url = Uri.parse('http://localhost:8081/v1/user/password/update');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode == 200) {
      return true; // 업데이트 성공
    } else {
      throw Exception('Failed to update password: ${response.statusCode}');
    }
  }
}
