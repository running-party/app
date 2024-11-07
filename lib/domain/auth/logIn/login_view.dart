import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../user/profile/profile_page.dart';
import '../../user/signUp/sign_up_page.dart';
import 'login_model.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _loginIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginModel>(
      builder: (context, loginModel, child) {
        // 로그인 성공 시 프로필 페이지로 이동
        if (loginModel.isLoggedIn) {
          Future.microtask(() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProfilePage(userId: _loginIdController.text)),
            );
            //loginModel.resetLoginStatus(); // 로그인 상태 초기화
          });
        }

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
                  MaterialPageRoute(
                      builder: (context) => SignUpPage()), // 회원가입 페이지로 이동
                );
              },
              child: Text('회원가입'),
            ),
            SizedBox(height: 20),

            // 구글 로그인 버튼
            ElevatedButton.icon(
              onPressed: () {
                _signInWithGoogle();
              },
              label: Text('구글 로그인'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 10),

            // 네이버 로그인 버튼
            ElevatedButton.icon(
              onPressed: () {
                _signInWithNaver();
              },
              label: Text('네이버 로그인'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 10),

            // 카카오 로그인 버튼
            ElevatedButton.icon(
              onPressed: () {
                _signInWithKakao();
              },
              label: Text('카카오 로그인'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFE812),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // 구글 로그인 메서드
  void _signInWithGoogle() {
    print("구글 로그인 시도");
  }

  // 네이버 로그인 메서드
  void _signInWithNaver() {
    print("네이버 로그인 시도");
  }

  // 카카오 로그인 메서드
  void _signInWithKakao() {
    print("카카오 로그인 시도");
  }
}
