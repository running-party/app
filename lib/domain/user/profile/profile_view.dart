// profile_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_model.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileModel = Provider.of<ProfileModel>(context);

    // 실제 프로필 데이터 로딩 상태 체크 부분을 주석 처리하고 가짜 데이터 사용
    /*
    if (profileModel.isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (profileModel.errorMessage.isNotEmpty) {
      return Center(child: Text(profileModel.errorMessage, style: TextStyle(color: Colors.red)));
    } else if (profileModel.profile == null) {
      return Center(child: Text('No profile data found.'));
    } else {
      final profile = profileModel.profile!;
    */

    // 가짜 데이터 설정
    final profile = {
      'name': '홍길동',
      'email': 'johndoe@example.com',
      'profilePictureUrl': 'https://via.placeholder.com/150'
    };

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(profile['profilePictureUrl']!), // 가짜 프로필 사진 URL
          ),
          SizedBox(height: 20),
          Text('Name: ${profile['name']}', style: TextStyle(fontSize: 18)), // 가짜 이름
          SizedBox(height: 10),
          Text('Email: ${profile['email']}', style: TextStyle(fontSize: 18)), // 가짜 이메일
        ],
      ),
    );
  }
}
