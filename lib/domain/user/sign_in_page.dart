// lib/src/auth/presentation/sign_in/sign_in_page.dart
import 'package:flutter/material.dart';
import 'sign_in_view.dart';  // ViewModel이나 상태를 관리하는 파일을 import

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: SignInView(),  // ViewModel 또는 상태 관리와 관련된 위젯을 호출
    );
  }
}
