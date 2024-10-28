// password_update_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'password_update_model.dart';
import 'password_update_view.dart';

class PasswordUpdatePage extends StatelessWidget {
  final String userId;

  PasswordUpdatePage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PasswordUpdateModel(),
      child: Scaffold(
        appBar: AppBar(title: Text('비밀번호 수정')),
        body: PasswordUpdateView(userId: userId),
      ),
    );
  }
}
