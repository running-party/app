// profile_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_model.dart';

class ProfileView extends StatefulWidget {
  final String userId;

  ProfileView({required this.userId});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool _isEditMode = false; // 수정 모드 상태
  int _selectedIndex = 0; // 현재 선택된 하단 메뉴 인덱스

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _profileImageUrlController =
      TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final profileModel = Provider.of<ProfileModel>(context, listen: false);

    if (profileModel.profile != null) {
      _usernameController.text = profileModel.profile!.username!;
      _emailController.text = profileModel.profile!.email;
      _profileImageUrlController.text = profileModel.profile!.profileImageUrl!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileModel = Provider.of<ProfileModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('프로필')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isEditMode)
              _buildEditMode(profileModel)
            else
              _buildViewMode(profileModel),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            // 각 인덱스에 따른 페이지 전환 로직 추가 가능
          });
        },
        selectedItemColor: Colors.blue, // 선택된 아이템 색상 (회원가입 버튼 스타일)
        unselectedItemColor: Colors.grey, // 선택되지 않은 아이템 색상
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: '대시보드',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: '활동',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: '러닝 기록',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: '클럽',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '내 정보',
          ),
        ],
      ),
    );
  }

  // 조회 모드 UI
  Widget _buildViewMode(ProfileModel profileModel) {
    if (profileModel.isFetching) {
      return Center(child: CircularProgressIndicator());
    } else if (profileModel.fetchErrorMessage.isNotEmpty) {
      return Center(
          child: Text(profileModel.fetchErrorMessage,
              style: TextStyle(color: Colors.red)));
    } else if (profileModel.profile == null) {
      return Center(child: Text('프로필 정보를 찾을 수 없습니다.'));
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('아이디: ${profileModel.profile!.userId}'),
          Text('이름: ${profileModel.profile!.username}'),
          Text('이메일: ${profileModel.profile!.email}'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isEditMode = true;
              });
            },
            child: Text('프로필 수정'),
          ),
        ],
      );
    }
  }

  // 수정 모드 UI
  Widget _buildEditMode(ProfileModel profileModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(labelText: '이름'),
        ),
        SizedBox(height: 20),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(labelText: '이메일'),
        ),
        SizedBox(height: 20),
        TextField(
          controller: _profileImageUrlController,
          decoration: InputDecoration(labelText: '프로필 이미지 URL'),
        ),
        SizedBox(height: 30),
        if (profileModel.isUpdating)
          Center(child: CircularProgressIndicator())
        else
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  profileModel
                      .updateProfile(
                    widget.userId,
                    _usernameController.text,
                    _emailController.text,
                    _profileImageUrlController.text,
                  )
                      .then((_) {
                    if (profileModel.isUpdated) {
                      setState(() {
                        _isEditMode = false;
                      });
                      profileModel.resetUpdateStatus();
                    }
                  });
                },
                child: Text('저장'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isEditMode = false;
                  });
                },
                child: Text('취소'),
              ),
            ],
          ),
        if (profileModel.updateErrorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              profileModel.updateErrorMessage,
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
