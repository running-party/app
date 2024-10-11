import 'package:flutter/material.dart';
import 'sign_up_view.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('회원가입 페이지 입니다')),
      body: SignUpView(),
    );
  }
}
