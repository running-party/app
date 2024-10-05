// lib/src/auth/presentation/sign_in/sign_in_view_model.dart
class SignInViewModel {
  Future<bool> signIn(String email, String password) async {
    // 여기에 실제 로그인 로직을 추가하세요.
    // 예를 들어, API 호출을 통해 로그인 인증을 수행합니다.

    // 예제 로직: 이메일과 비밀번호가 'test@example.com'과 'password123'인 경우만 로그인 성공
    if (email == 'test@example.com' && password == 'password123') {
      return true;
    } else {
      return false;
    }
  }
}
