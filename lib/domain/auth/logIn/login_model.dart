import 'package:flutter/material.dart';
import '../../../dto/login_dto.dart';
import 'login_api.dart';

class LoginModel with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> login(String loginId, String password) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final loginDto = LoginDto(loginId: loginId, password: password);
      await LoginApi.login(loginDto);
      // 성공 처리 (JWT 토큰 저장 등)
    } catch (e) {
      _errorMessage = '로그인에 실패했습니다. 다시 시도해주세요.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
