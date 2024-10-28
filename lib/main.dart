import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'domain/auth/logIn/login_page.dart';
import 'domain/user/signUp/sign_up_model.dart';
import 'domain/user/signUp/sign_up_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SignUpModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}
