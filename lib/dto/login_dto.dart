class LoginDto {
  final String loginId;
  final String password;

  LoginDto({
    required this.loginId,
    required this.password,
  });

  // DTO를 JSON으로 변환 (API 요청에 사용)
  Map<String, dynamic> toJson() {
    return {
      'loginId': loginId,
      'password': password,
    };
  }

  // JSON을 DTO로 변환 (API 응답 처리 시 사용)
  factory LoginDto.fromJson(Map<String, dynamic> json) {
    return LoginDto(
      loginId: json['loginId'],
      password: json['password'],
    );
  }
}
