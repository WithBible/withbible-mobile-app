import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:withbible_app/common/alert_util.dart';
import 'package:withbible_app/common/theme_helper.dart';
import 'package:withbible_app/data/categories.dart';
import 'package:withbible_app/data/user.dart';
import 'package:withbible_app/screen/quiz_category_detail_screen.dart';
import 'package:withbible_app/widget/category_header_widget.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('성경 졸업고사 퀴즈'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.centerLeft,
              child: buildWelcome(username),
            ),
          ),
          actions: const [
            Icon(Icons.search),
            SizedBox(width: 12),
          ],
        ),
        drawer: navigationDrawer(context),
        body: Container(
          decoration: BoxDecoration(
            color: ThemeHelper.shadowColor
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              const SizedBox(height: 8),
              buildCategories(context),
            ],
          ),
        ),
    );
  }

  Widget buildWelcome(String username) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hello',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        Text(
          username,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget buildCategories(BuildContext context) {
    return SizedBox(
      height: 400,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 4 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: categories
            .map((category) => GestureDetector(
                  child: CategoryHeaderWidget(category: category),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        QuizCategoryDetailScreen.routeName,
                        arguments: category);
                  },
                ))
            .toList(),
      ),
    );
  }

  Drawer navigationDrawer(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: ThemeHelper.accentColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Version: 1.00",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
        ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            }),
        const Divider(
          thickness: 2,
        ),
        ListTile(
            title: const Text('About'),
            onTap: () {
              AlertUtil.showAlert(context, "About us", "More at ...");
            }),
        ListTile(
            title: const Text('Exit'),
            onTap: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            })
      ],
    ));
  }
}
