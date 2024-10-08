// 파일명: board_page.dart
import 'package:flutter/material.dart';
import 'board_api.dart';
import 'board_model.dart';
import 'board_view.dart';

class BoardPage extends StatefulWidget {
  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  late Future<List<BoardModel>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = BoardApi().fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시판'),
      ),
      body: FutureBuilder<List<BoardModel>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load posts: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No posts available'));
          } else {
            return BoardView(posts: snapshot.data!);
          }
        },
      ),
    );
  }
}
