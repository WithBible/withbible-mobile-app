import 'package:flutter/material.dart';
import 'package:withbible_app/common/theme_helper.dart';
import 'package:withbible_app/screen/account_screen.dart';
import 'package:withbible_app/screen/home_screen.dart';
import 'package:withbible_app/screen/leader_boards_screen.dart';
import 'package:withbible_app/screen/quiz_history_screen.dart';

class BottomWidget extends StatefulWidget {
  static const routeName = "/bottom";

  const BottomWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  List<Widget> screens = [
    const HomeScreen(),
    LeaderBoardsScreen(),
    const QuizHistoryScreen(),
    AccountScreen()
  ];
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: ThemeHelper.shadowColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        onTap: onTap,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, color: Color(0xfffbce7b)),
              label: 'Home',
              activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard_outlined, color: Color(0xfffbce7b)),
              label: 'LeaderBoards',
              activeIcon: Icon(Icons.leaderboard)),
          BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined, color: Color(0xfffbce7b)),
              label: 'History',
              activeIcon: Icon(Icons.history)),
          BottomNavigationBarItem(
              icon:
                  Icon(Icons.account_circle_outlined, color: Color(0xfffbce7b)),
              label: 'Account',
              activeIcon: Icon(Icons.account_circle)),
        ],
      ),
    );
  }
}
