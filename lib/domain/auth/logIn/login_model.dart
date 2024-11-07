import 'package:flutter/material.dart';
import '../../../dto/login_dto.dart';
import '../../../dto/profile_dto.dart';
import '../../user/profile/profile_api.dart';
import 'login_api.dart';

class LoginModel with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';
  bool _isLoggedIn = false;
  ProfileDto? _profile; // 프로필 데이터를 저장할 변수

  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;

  bool get isLoggedIn => _isLoggedIn;

  ProfileDto? get profile => _profile; // 프로필 정보를 외부에서 접근 가능하게 함

  Future<void> login(String loginId, String password) async {
    _isLoading = true;
    _errorMessage = '';
    _isLoggedIn = false;
    notifyListeners();

    try {
      final loginDto = LoginDto(loginId: loginId, password: password);
      await LoginApi.login(loginDto);
      print('로그인 되었습니다.');

      // 로그인 성공 처리
      _isLoggedIn = true;

      // 프로필 조회 API 호출
      _profile = await ProfileApi.getProfile(loginId);
      print('프로필 정보 조회 완료: $_profile');
    } catch (e) {
      _errorMessage = '로그인에 실패했습니다. 다시 시도해주세요.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 로그아웃 메서드 추가: 상태 초기화 및 알림
  void logout() {
    _isLoggedIn = false;
    _profile = null;
    notifyListeners();
  }

  // 에러 상태 초기화 메서드
  void resetErrorMessage() {
    _errorMessage = '';
    notifyListeners();
  }
}
