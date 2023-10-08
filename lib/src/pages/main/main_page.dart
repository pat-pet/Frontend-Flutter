import 'package:flutter/material.dart';
import 'package:frontend_flutter/src/pages/main/chat/chat_page.dart';
import 'package:frontend_flutter/src/pages/main/home/home_page.dart';
import 'package:frontend_flutter/src/pages/main/profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _bottomNavigationIndex = 0;

  Widget getMainPage() {
    if (_bottomNavigationIndex == 0) {
      return const HomePage();
    } else if (_bottomNavigationIndex == 1) {
      return const ChatPage();
    } else {
      return const ProfilePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (newIndex) {
          setState(() {
            _bottomNavigationIndex = newIndex;
          });
        },
        currentIndex: _bottomNavigationIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Profile',
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      body: SafeArea(
        child: getMainPage(),
      ),
    );
  }
}
