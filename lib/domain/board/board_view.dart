// 파일명: board_view.dart
import 'package:flutter/material.dart';
import 'board_model.dart';

class BoardView extends StatelessWidget {
  final List<BoardModel> posts;

  BoardView({required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return ListTile(
          title: Text(post.title),
          subtitle: Text('작성자: ${post.author}'),
          onTap: () {
            // 게시물 클릭 시 상세페이지로 이동하는 로직 추가 가능
          },
        );
      },
    );
  }
}
