// profile_update_dto.dart
class ProfileUpdateDto {
  final String userId;
  final String username;
  final String email;
  final String profileImageUrl;

  ProfileUpdateDto({
    required this.userId,
    required this.username,
    required this.email,
    required this.profileImageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'profileImageUrl': profileImageUrl,
    };
  }
}
