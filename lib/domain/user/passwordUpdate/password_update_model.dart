// password_update_model.dart
import 'package:flutter/material.dart';
import '../../../dto/password_update_dto.dart';
import 'password_update_api.dart';

class PasswordUpdateModel with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> updatePassword(
      String userId, String currentPassword, String newPassword) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    final dto = PasswordUpdateDto(
      userId: userId,
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    try {
      await PasswordUpdateApi.updatePassword(dto);
    } catch (e) {
      _errorMessage = '비밀번호 업데이트에 실패했습니다.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
