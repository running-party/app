import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runningpartyapp/domain/user/signUp/sign_up_model.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _loginIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signUpModel = Provider.of<SignUpModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Text(
              '회원가입',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent, // 스포티한 포인트 컬러
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            _buildTextField(
              controller: _loginIdController,
              label: '로그인 ID',
              icon: Icons.person,
              validator: (value) => value!.isEmpty ? '로그인 ID를 입력하세요' : null,
            ),
            _buildTextField(
              controller: _passwordController,
              label: '비밀번호',
              icon: Icons.lock,
              isPassword: true,
              validator: (value) => value!.isEmpty ? '비밀번호를 입력하세요' : null,
            ),
            _buildTextField(
              controller: _nicknameController,
              label: '닉네임',
              icon: Icons.account_circle,
              validator: (value) => value!.isEmpty ? '닉네임을 입력하세요' : null,
            ),
            _buildTextField(
              controller: _emailController,
              label: '이메일',
              icon: Icons.email,
              validator: (value) => value!.isEmpty ? '이메일을 입력하세요' : null,
            ),
            SizedBox(height: 30),
            if (signUpModel.isLoading)
              Center(child: CircularProgressIndicator())
            else
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    signUpModel.signUp(
                      _loginIdController.text,
                      _passwordController.text,
                      _nicknameController.text,
                      _emailController.text,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.blueAccent, // 스포티한 포인트 컬러
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  '회원가입',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            if (signUpModel.errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  signUpModel.errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // 재사용 가능한 TextFormField 생성 (아이콘 추가)
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,  // 아이콘 추가
    bool isPassword = false,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blueAccent),  // 아이콘 추가
          labelStyle: TextStyle(color: Colors.blueAccent), // 스포티한 느낌
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),  // 필드의 둥근 모서리
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: validator,
      ),
    );
  }

  @override
  void dispose() {
    _loginIdController.dispose();
    _passwordController.dispose();
    _nicknameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
