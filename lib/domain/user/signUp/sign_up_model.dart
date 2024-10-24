import 'package:flutter/material.dart';
import 'package:runningpartyapp/domain/user/signUp/sign_up_api.dart';

import '../../../dto/user_dto.dart';

class SignUpModel with ChangeNotifier {
  final SignUpApi _api = SignUpApi(); // API와 통신

  // 상태 관리 필드
  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // 로딩 상태 관리
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // 에러 메시지 초기화
  void clearErrorMessage() {
    _errorMessage = '';
    notifyListeners();
  }

  // 회원가입 처리
  Future<bool> signUp(String loginId, String password, String nickname, String email) async {
    _setLoading(true);

    UserDto userDto = UserDto(
      loginId: loginId,
      password: password,
      nickname: nickname,
      email: email,
    );

    bool success = await _api.signUpUser(userDto);

    if (success) {
      _setLoading(false);
      return true;
    } else {
      _errorMessage = '회원가입에 실패했습니다.';
      _setLoading(false);
      return false;
    }
  }
}
