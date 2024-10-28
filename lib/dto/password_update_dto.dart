// password_update_dto.dart
class PasswordUpdateDto {
  final String userId;
  final String currentPassword;
  final String newPassword;

  PasswordUpdateDto({
    required this.userId,
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    };
  }
}
