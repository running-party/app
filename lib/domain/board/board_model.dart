// 파일명: board_model.dart
class BoardModel {
  final int id;
  final String title;
  final String content;
  final String author;
  final DateTime date;

  BoardModel({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.date,
  });

  factory BoardModel.fromJson(Map<String, dynamic> json) {
    return BoardModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      author: json['author'],
      date: DateTime.parse(json['date']),
    );
  }
}
