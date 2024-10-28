// profile_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../dto/profile_dto.dart';
import '../../../dto/profile_update_dto.dart';

class ProfileApi {
  // 프로필 정보를 조회하는 메서드
  static Future<ProfileDto> fetchProfile(String userId) async {
    final url = Uri.parse('http://localhost:8081/v1/user/profile/$userId');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return ProfileDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load profile: ${response.statusCode}');
    }
  }

  // 프로필 정보를 수정하는 메서드
  static Future<bool> updateProfile(ProfileUpdateDto dto) async {
    final url = Uri.parse('http://localhost:8081/v1/user/profile/update');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode == 200) {
      return true; // 수정 성공
    } else {
      throw Exception('Failed to update profile: ${response.statusCode}');
    }
  }
}
