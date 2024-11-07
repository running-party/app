import 'package:flutter/material.dart';
import '../../../dto/profile_dto.dart';
import '../../../dto/profile_update_dto.dart';
import 'profile_api.dart';

class ProfileModel with ChangeNotifier {
  // 조회 상태 변수
  bool _isFetching = false;
  ProfileDto? _profile; // Nullable, 초기 값은 null
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
    if (_isFetching) return; // 이미 조회 중이면 중복 호출 방지

    _isFetching = true;
    _fetchErrorMessage = '';
    notifyListeners();

    try {
      _profile = await ProfileApi.getProfile(userId);
      if (_profile == null) {
        _fetchErrorMessage = 'No profile data found';
      }
    } catch (e) {
      _fetchErrorMessage = 'Failed to load profile: $e'; // 상세 에러 메시지
      debugPrint('Error loading profile: $e'); // 에러 로깅
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  // 프로필 정보를 수정하는 메서드
  Future<void> updateProfile(String userId, String username, String email,
      String profileImageUrl) async {
    if (_isUpdating) return; // 이미 수정 중이면 중복 호출 방지

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
          profileImageUrl: profileImageUrl,
          name: '',
          profilePictureUrl: '',
        );
      } else {
        _updateErrorMessage = 'Failed to update profile: Unknown error';
      }
    } catch (e) {
      _updateErrorMessage = 'Failed to update profile: $e'; // 상세 에러 메시지
      debugPrint('Error updating profile: $e'); // 에러 로깅
    } finally {
      _isUpdating = false;
      notifyListeners();
    }
  }

  // 업데이트 상태 초기화 메서드
  void resetUpdateStatus() {
    if (_isUpdated) {
      _isUpdated = false;
      notifyListeners();
    }
  }
}
