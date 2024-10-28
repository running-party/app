// profile_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../dto/profile_dto.dart';


class ProfileApi {
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
}
