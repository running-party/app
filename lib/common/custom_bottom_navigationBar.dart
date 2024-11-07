// custom_bottom_navigation_bar.dart
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTabSelected,
      selectedItemColor: Colors.blue,
      // 선택된 아이템 색상
      unselectedItemColor: Colors.grey,
      // 선택되지 않은 아이템 색상
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
    );
  }
}
