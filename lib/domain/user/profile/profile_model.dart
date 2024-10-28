// profile_model.dart
import 'package:flutter/material.dart';
import '../../../dto/profile_dto.dart';
import 'profile_api.dart';

class ProfileModel with ChangeNotifier {
  bool _isLoading = false;
  ProfileDto? _profile;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  ProfileDto? get profile => _profile;
  String get errorMessage => _errorMessage;

  Future<void> loadProfile(String userId) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _profile = await ProfileApi.fetchProfile(userId);
    } catch (e) {
      _errorMessage = 'Failed to load profile';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
