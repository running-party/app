import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../user/signUp/sign_up_page.dart';
import 'login_model.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _loginIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginModel = Provider.of<LoginModel>(context);

    return Column(
      children: [
        TextField(
          controller: _loginIdController,
          decoration: InputDecoration(labelText: '아이디'),
        ),
        SizedBox(height: 20),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(labelText: '비밀번호'),
          obscureText: true,
        ),
        SizedBox(height: 30),
        if (loginModel.isLoading)
          CircularProgressIndicator()
        else
          ElevatedButton(
            onPressed: () {
              loginModel.login(
                _loginIdController.text,
                _passwordController.text,
              );
            },
            child: Text('로그인'),
          ),
        if (loginModel.errorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              loginModel.errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          ),
        TextButton(
          onPressed: () {
            // 비밀번호 찾기 페이지로 이동
          },
          child: Text('비밀번호 찾기'),
        ),
        TextButton(
          onPressed: () {
            // 회원가입 페이지로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpPage()), // 회원가입 페이지로 이동
            );
          },
          child: Text('회원가입'),
        ),
      ],
    );
  }
}
