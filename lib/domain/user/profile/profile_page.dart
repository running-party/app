// profile_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_model.dart';
import 'profile_view.dart';

class ProfilePage extends StatelessWidget {
  final String userId;

  ProfilePage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileModel()..loadProfile(userId),
      child: Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: ProfileView(),
      ),
    );
  }
}
