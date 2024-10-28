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

  bool _isLoginIdChecked = false;
  bool _isCheckingLoginId = false;

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
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            _buildTextField(
              controller: _loginIdController,
              label: '로그인 ID',
              icon: Icons.person,
              validator: (value) => value!.isEmpty ? '로그인 ID를 입력하세요' : null,
              suffixButton: _buildCheckButton(), // 중복 체크 버튼 추가
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
                  if (_formKey.currentState!.validate() && _isLoginIdChecked) {
                    signUpModel.signUp(
                      _loginIdController.text,
                      _passwordController.text,
                      _nicknameController.text,
                      _emailController.text,
                    );
                  } else if (!_isLoginIdChecked) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('아이디 중복 체크를 완료해주세요.'),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.blue, // 현대적인 파란색
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

  // 중복 체크 버튼 생성
  Widget _buildCheckButton() {
    return ElevatedButton(
      onPressed: _isCheckingLoginId
          ? null // 로딩 중이면 버튼 비활성화
          : () async {
        setState(() {
          _isCheckingLoginId = true;
        });
        // 여기서 아이디 중복 체크 로직 호출
        bool isAvailable = await _checkLoginIdAvailability(_loginIdController.text);
        setState(() {
          _isLoginIdChecked = isAvailable;
          _isCheckingLoginId = false;
        });

        // 중복 결과 처리
        if (!isAvailable) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('아이디가 이미 존재합니다.'),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('사용 가능한 아이디입니다.'),
          ));
        }
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: _isCheckingLoginId
          ? SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      )
          : Text(
        '중복 체크',
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  Future<bool> _checkLoginIdAvailability(String loginId) async {
    // 실제로 아이디 중복 체크 API를 호출하는 로직을 여기에 작성
    await Future.delayed(Duration(seconds: 2)); // 예시로 딜레이 추가
    return loginId != "already_taken"; // 예시로 "already_taken"은 중복된 아이디로 가정
  }

  // 재사용 가능한 TextFormField 생성 (아이콘 및 중복체크 버튼 추가)
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    required String? Function(String?) validator,
    Widget? suffixButton, // 추가적인 버튼 (중복 체크 버튼)
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blue), // 현대적인 파란색 포인트 컬러
          labelStyle: TextStyle(color: Colors.blue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: suffixButton, // 아이디 중복 체크 버튼 추가
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
