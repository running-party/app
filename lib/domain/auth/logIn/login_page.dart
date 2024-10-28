import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_model.dart';
import 'login_view.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('로그인'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LoginView(),
        ),
      ),
    );
  }
}
