// password_update_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'password_update_model.dart';

class PasswordUpdateView extends StatelessWidget {
  final String userId;

  PasswordUpdateView({required this.userId});

  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final passwordUpdateModel = Provider.of<PasswordUpdateModel>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _currentPasswordController,
            decoration: InputDecoration(labelText: '현재 비밀번호'),
            obscureText: true,
          ),
          SizedBox(height: 20),
          TextField(
            controller: _newPasswordController,
            decoration: InputDecoration(labelText: '새 비밀번호'),
            obscureText: true,
          ),
          SizedBox(height: 20),
          TextField(
            controller: _confirmNewPasswordController,
            decoration: InputDecoration(labelText: '새 비밀번호 확인'),
            obscureText: true,
          ),
          SizedBox(height: 30),
          if (passwordUpdateModel.isLoading)
            Center(child: CircularProgressIndicator())
          else
            ElevatedButton(
              onPressed: () {
                if (_newPasswordController.text ==
                    _confirmNewPasswordController.text) {
                  passwordUpdateModel.updatePassword(
                    userId,
                    _currentPasswordController.text,
                    _newPasswordController.text,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('새 비밀번호가 일치하지 않습니다.')),
                  );
                }
              },
              child: Text('비밀번호 수정'),
            ),
          if (passwordUpdateModel.errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                passwordUpdateModel.errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}
