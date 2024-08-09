// boardView.dart
import 'package:flutter/material.dart';
import 'board_api.dart';

class BoardView extends StatelessWidget {
  final List<Board> boards;

  BoardView({required this.boards});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: boards.length,
      itemBuilder: (context, index) {
        return ListTile(
          // title: Text(boards[index].title),
          subtitle: Text(boards[index].content),
        );
      },
    );
  }
}
