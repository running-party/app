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
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isLoginIdChecked = false;
  bool _isNicknameChecked = false;
  bool _isCheckingLoginId = false;
  bool _isCheckingNickname = false;

  @override
  Widget build(BuildContext context) {
    final signUpModel = Provider.of<SignUpModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form( // 전체 폼을 감싸는 Form 위젯 추가
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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

            // 로그인 ID 입력 필드 (중복 체크 포함)
            TextFormField(
              controller: _loginIdController,
              decoration: InputDecoration(
                labelText: '아이디',
                suffixIcon: _buildCheckButton(
                  label: '중복 체크',
                  isChecking: _isCheckingLoginId,
                  onPressed: () async {
                    setState(() {
                      _isCheckingLoginId = true;
                    });
                    bool isAvailable = await _checkLoginIdAvailability(_loginIdController.text);
                    setState(() {
                      _isLoginIdChecked = isAvailable;
                      _isCheckingLoginId = false;
                    });
                    _showCheckResultMessage(isAvailable, '아이디');
                  },
                ),
              ),
              validator: (value) { // 유효성 검사 추가
                if (value == null || value.isEmpty) {
                  return '아이디를 입력해주세요.';
                }
                return null;
              },
            ),
            SizedBox(height: 20),

            // 비밀번호 입력 필드
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: '비밀번호'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '비밀번호를 입력해주세요.';
                } else if (value.length < 6) {
                  return '비밀번호는 최소 6자리 이상이어야 합니다.';
                }
                return null;
              },
            ),
            SizedBox(height: 20),

            // 비밀번호 확인 입력 필드
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: '비밀번호 확인'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '비밀번호 확인을 입력해주세요.';
                } else if (value != _passwordController.text) {
                  return '비밀번호가 일치하지 않습니다.';
                }
                return null;
              },
            ),
            SizedBox(height: 20),

            // 닉네임 입력 필드 (중복 체크 포함)
            TextFormField(
              controller: _nicknameController,
              decoration: InputDecoration(
                labelText: '닉네임',
                suffixIcon: _buildCheckButton(
                  label: '중복 체크',
                  isChecking: _isCheckingNickname,
                  onPressed: () async {
                    setState(() {
                      _isCheckingNickname = true;
                    });
                    bool isAvailable = await _checkNicknameAvailability(_nicknameController.text);
                    setState(() {
                      _isNicknameChecked = isAvailable;
                      _isCheckingNickname = false;
                    });
                    _showCheckResultMessage(isAvailable, '닉네임');
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '닉네임을 입력해주세요.';
                }
                return null;
              },
            ),
            SizedBox(height: 20),

            // 이메일 입력 필드
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: '이메일'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '이메일을 입력해주세요.';
                }
                // 간단한 이메일 유효성 검사
                else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return '유효한 이메일 주소를 입력해주세요.';
                }
                return null;
              },
            ),
            SizedBox(height: 30),

            if (signUpModel.isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate() &&
                      _isLoginIdChecked &&
                      _isNicknameChecked) {
                    signUpModel.signUp(
                      _loginIdController.text,
                      _passwordController.text,
                      _nicknameController.text,
                      _emailController.text,
                    );
                  } else {
                    _showSnackbar('아이디와 닉네임 중복 체크를 완료해주세요.');
                  }
                },
                child: Text('회원가입'),
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

  Widget _buildCheckButton({required String label, required bool isChecking, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: isChecking ? null : onPressed,
      style: ElevatedButton.styleFrom(),
      child: isChecking
          ? SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      )
          : Text(label),
    );
  }

  Future<bool> _checkLoginIdAvailability(String loginId) async {
    await Future.delayed(Duration(seconds: 2));
    return loginId != "already_taken";
  }

  Future<bool> _checkNicknameAvailability(String nickname) async {
    await Future.delayed(Duration(seconds: 2));
    return nickname != "existing_nickname";
  }

  void _showCheckResultMessage(bool isAvailable, String fieldType) {
    String message = isAvailable ? '사용 가능한 $fieldType입니다.' : '$fieldType가 이미 존재합니다.';
    _showSnackbar(message);
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _loginIdController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nicknameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
