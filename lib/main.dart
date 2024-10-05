// main.dart
import 'package:flutter/material.dart';
import 'package:runningpartyapp/user/sign_in_page.dart';
//import 'board/board_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Spring Boot API Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInPage(),
    );
  }
}
