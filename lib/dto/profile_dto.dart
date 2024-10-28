// profile_dto.dart
class ProfileDto {
  final String name;
  final String email;
  final String profilePictureUrl;

  ProfileDto({required this.name, required this.email, required this.profilePictureUrl});

  factory ProfileDto.fromJson(Map<String, dynamic> json) {
    return ProfileDto(
      name: json['name'],
      email: json['email'],
      profilePictureUrl: json['profilePictureUrl'],
    );
  }
}
