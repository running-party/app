// 파일명: board_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'board_model.dart';

class BoardApi {
  final String baseUrl = 'http://your-api-url.com/api/board';

  Future<List<BoardModel>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((post) => BoardModel.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
