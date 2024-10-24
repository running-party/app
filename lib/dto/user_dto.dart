class UserDto {
  String? id; // 서버 응답용 (optional)
  String loginId;
  String password;
  String nickname;
  String email;
  String? image; // 프로필 이미지 (optional)
  String? role; // 사용자 역할 (optional)
  String? kakaoId; // 카카오 로그인 ID (optional)
  bool? isArchived; // 탈퇴 여부 (optional)

  // 생성자
  UserDto({
    this.id,
    required this.loginId,
    required this.password,
    required this.nickname,
    required this.email,
    this.image,
    this.role,
    this.kakaoId,
    this.isArchived,
  });

  // JSON 데이터를 객체로 변환하는 메서드
  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as String?,
      loginId: json['loginId'] as String,
      password: json['password'] as String,
      nickname: json['nickname'] as String,
      email: json['email'] as String,
      image: json['image'] as String?,
      role: json['role'] as String?,
      kakaoId: json['kakaoId'] as String?,
      isArchived: json['isArchived'] as bool?,
    );
  }

  // 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'loginId': loginId,
      'password': password,
      'nickname': nickname,
      'email': email,
      'image': image,
      'role': role,
      'kakaoId': kakaoId,
      'isArchived': isArchived,
    };
  }
}