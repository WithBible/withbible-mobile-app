import 'package:flutter/material.dart';
import 'package:withbible_app/data/categories.dart';
import 'package:withbible_app/data/user.dart';
import 'package:withbible_app/widget/category_header_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu),
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
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.purple],
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight)),
          ),
          actions: const [
            Icon(Icons.search),
            SizedBox(width: 12),
          ],
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 8),
            buildCategories(),
          ],
        ));
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

  Widget buildCategories() {
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
            .map((category) => CategoryHeaderWidget(category: category))
            .toList(),
      ),
    );
  }
}
