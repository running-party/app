// main.dart
import 'package:flutter/material.dart';
import 'board/boardPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Spring Boot API Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BoardPage(),
    );
  }
}
