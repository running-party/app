// profile_model.dart
import 'package:flutter/material.dart';
import '../../../dto/profile_dto.dart';
import '../../../dto/profile_update_dto.dart';
import 'profile_api.dart';

class ProfileModel with ChangeNotifier {
  // 조회 상태 변수
  bool _isFetching = false;
  ProfileDto? _profile;
  String _fetchErrorMessage = '';

  // 수정 상태 변수
  bool _isUpdating = false;
  String _updateErrorMessage = '';
  bool _isUpdated = false;

  // 조회 상태 접근자
  bool get isFetching => _isFetching;
  ProfileDto? get profile => _profile;
  String get fetchErrorMessage => _fetchErrorMessage;

  // 수정 상태 접근자
  bool get isUpdating => _isUpdating;
  String get updateErrorMessage => _updateErrorMessage;
  bool get isUpdated => _isUpdated;

  // 프로필 정보를 로드하는 메서드
  Future<void> loadProfile(String userId) async {
    _isFetching = true;
    _fetchErrorMessage = '';
    notifyListeners();

    try {
      _profile = await ProfileApi.fetchProfile(userId);
    } catch (e) {
      _fetchErrorMessage = 'Failed to load profile';
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  // 프로필 정보를 수정하는 메서드
  Future<void> updateProfile(String userId, String username, String email, String profileImageUrl) async {
    _isUpdating = true;
    _updateErrorMessage = '';
    _isUpdated = false;
    notifyListeners();

    final dto = ProfileUpdateDto(
      userId: userId,
      username: username,
      email: email,
      profileImageUrl: profileImageUrl,
    );

    try {
      final success = await ProfileApi.updateProfile(dto);
      if (success) {
        _isUpdated = true; // 수정 성공 시 상태를 업데이트
        _profile = ProfileDto(
          userId: userId,
          username: username,
          email: email,
          profileImageUrl: profileImageUrl, name: '', profilePictureUrl: '',
        );
      }
    } catch (e) {
      _updateErrorMessage = 'Failed to update profile';
    } finally {
      _isUpdating = false;
      notifyListeners();
    }
  }

  // 업데이트 상태 초기화 메서드
  void resetUpdateStatus() {
    _isUpdated = false;
    notifyListeners();
  }
}
