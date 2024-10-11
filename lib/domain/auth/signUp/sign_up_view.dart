import 'package:flutter/material.dart';
import 'sign_up_model.dart';
import 'sign_up_api.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signUp() async {
    SignUpModel model = SignUpModel(
      email: _emailController.text,
      password: _passwordController.text,
    );

    bool success = await SignUpApi.signUp(model);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign up successful')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign up failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: '이메일'),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: '비밀번호'),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: _signUp,
            child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
