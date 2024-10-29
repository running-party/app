import 'package:flutter/material.dart';
import '../../../dto/login_dto.dart';
import 'login_api.dart';

class LoginModel with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';
  bool _isLoggedIn = false; // 로그인 성공 상태 추가

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get isLoggedIn => _isLoggedIn; // 로그인 성공 상태 확인

  Future<void> login(String loginId, String password) async {
    _isLoading = true;
    _errorMessage = '';
    _isLoggedIn = false; // 초기화
    notifyListeners();

    try {
      final loginDto = LoginDto(loginId: loginId, password: password);
      await LoginApi.login(loginDto);
      print('로그인 되었습니다.');

      // 로그인 성공 처리
      _isLoggedIn = true; // 로그인 성공 상태 변경
      // 여기서 토큰 저장 등 추가 처리가 필요하면 할 수 있습니다.
    } catch (e) {
      _errorMessage = '로그인에 실패했습니다. 다시 시도해주세요.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
