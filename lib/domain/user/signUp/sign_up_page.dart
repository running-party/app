import 'package:flutter/material.dart';
import 'sign_up_view.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(  // MaterialApp 대신 Scaffold 사용
      appBar: AppBar(
        //title: Text('Sign Up'),
      ),
      body: SignUpView(),
    );
  }
}
