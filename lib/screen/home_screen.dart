import 'package:flutter/material.dart';
import 'package:withbible_app/common/theme_helper.dart';
import 'package:withbible_app/data/categories.dart';
import 'package:withbible_app/data/user.dart';
import 'package:withbible_app/screen/quiz/category_detail_screen.dart';
import 'package:withbible_app/widget/category_header_widget.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('위드 바이블'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: buildWelcome(name),
          ),
        ),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 12),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: ThemeHelper.shadowColor),
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

  Widget buildWelcome(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$name님',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const Text(
          '성경 졸업고사 패스를 기원합니다!',
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ],
    );
  }

  Widget buildCategories(BuildContext context) {
    return SizedBox(
      height: 400,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
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
}
