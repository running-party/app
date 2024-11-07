// profile_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../dto/profile_dto.dart';
import '../../../dto/profile_update_dto.dart';

class ProfileApi {
  // 프로필 정보를 조회하는 메서드
  static Future<ProfileDto> getProfile(String loginId) async {
    // 실제 API 호출
    /*final response = await http.get(Uri.parse
    ('http://localhost:8081/api/v1/user/$loginId/profile'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ProfileDto.fromJson(data);
    } else {
      throw Exception('프로필 정보를 불러오는데 실패했습니다.');
    }*/

    // 아래는 테스트를 위한 가짜 데이터
    // 테스트 환경에서 실제 API 대신 사용할 수 있습니다.
    // 예: API 서버가 작동하지 않거나 테스트 데이터를 사용해야 할 때

    await Future.delayed(Duration(seconds: 1)); // API 호출 시 대기 시간을 시뮬레이션
    final fakeData = {
      "userId": loginId,
      "username": "Test User",
      "email": "testuser@example.com",
      "profileImageUrl": "https://example.com/profile.jpg",
      "name": "Test Name",
      "profilePictureUrl": "https://example.com/profile-picture.jpg"
    };
    return ProfileDto.fromJson(fakeData);
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
