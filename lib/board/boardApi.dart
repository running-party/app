import 'dart:convert';
import 'package:http/http.dart' as http;

class Board {
  final int id;
  final String name;
  final String content;

  Board({required this.id, required this.name, required this.content});

  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      id: json['id'] ?? 0, // 기본값 설정
      name: json['name'] ?? 'Unknown', // 기본값 설정
      content: json['content'] ?? 'No Content', // 기본값 설정
    );
  }



  static Future<List<Board>> fetchBoards() async {
    try {
      final response = await http.get(Uri.parse
        ("http://localhost:8081/api/boards"));
      // 포트 번호 확인


      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Board.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load boards: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load boards: $e');
    }
  }

}
