import 'package:flutter/material.dart';
import 'boardApi.dart';
import 'boardView.dart';

class BoardPage extends StatefulWidget {
  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  Future<List<Board>>? futureBoards;

  void _fetchData() {
    setState(() {
      futureBoards = Board.fetchBoards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Board Page'),
      ),
      body: Center(
        child: futureBoards == null
            ? ElevatedButton(
          onPressed: _fetchData,
          child: Text('Load Boards'),
        )
            : FutureBuilder<List<Board>>(
          future: futureBoards,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return BoardView(boards: snapshot.data!);
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
            return Text('No data available');
          },
        ),
      ),
    );
  }

}
