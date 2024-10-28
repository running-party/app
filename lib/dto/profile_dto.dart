// profile_dto.dart
class ProfileDto {
  final String name;
  final String email;
  final String profilePictureUrl;

  ProfileDto({required this.name, required this.email, required this.profilePictureUrl, required String username, required String userId, required String profileImageUrl});

  factory ProfileDto.fromJson(Map<String, dynamic> json) {
    return ProfileDto(
      name: json['name'],
      email: json['email'],
      profilePictureUrl: json['profilePictureUrl'], username: '', userId: '', profileImageUrl: '',
    );
  }

  String? get username => null;

  String? get profileImageUrl => null;

  get userId => null;
}
