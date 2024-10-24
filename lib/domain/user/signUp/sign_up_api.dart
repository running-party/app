import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../dto/user_dto.dart';

class SignUpApi {
  final String _baseUrl = 'http://localhost:8081/v1/user';

  Future<bool> signUpUser(UserDto userDto) async {
    try {
      // UserDto를 JSON으로 변환
      final response = await http.post(
        Uri.parse('$_baseUrl/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userDto.toJson()),
      );

      // 상태 코드 확인
      if (response.statusCode == 200) {
        print("회원가입 성공: ${response.body}");
        return true;
      } else {
        print("회원가입 실패: ${response.statusCode}, ${response.body}");
        return false;
      }
    } catch (e) {
      // 에러 처리 (네트워크 에러 등)
      print("에러 발생: $e");
      return false;
    }
  }
}
