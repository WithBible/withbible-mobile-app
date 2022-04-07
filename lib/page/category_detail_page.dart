import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:withbible_app/common/theme_helper.dart';
import 'package:withbible_app/model/category.dart';
import 'package:withbible_app/model/quiz.dart';

class CategoryDetailPage extends StatefulWidget {
  static const routeName = '/categoryDetail';
  late Category category;

  CategoryDetailPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryDetailPageState(category);
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  late Category category;
  late List<Quiz> quizList = [];

  _CategoryDetailPageState(this.category);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          alignment: Alignment.center,
          child: Column(
            children: [
              pageHeader(category),
              Expanded(
                child: categoryDetailView(quizList),
              ),
            ],
          ),
        ),
    ))
    ;
  }

  pageHeader(Category category) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          GestureDetector(
            child: FaIcon(category.icon, color: Colors.white, size: 36),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Text(
            "${category.categoryName} Quiz",
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }

  categoryDetailView(List<Quiz> quizList) {
    return SingleChildScrollView(
      child: Column(
        children: quizList
            .map((quiz) => GestureDetector(
          child: categoryDetailItemView(quiz),
          onTap: () {
            Navigator.of(context).pushNamed("/quiz", arguments: quiz);
          },
        ))
            .toList(),
      ),
    );
  }

  categoryDetailsItemBadge(Quiz quiz) {
    return Container(
      alignment: Alignment.topRight,
      child: Container(
        width: 150,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ThemeHelper.primaryColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            )),
        child: Text(
          "${quiz.questions.length} Questions",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  categoryDetailItemView(Quiz quiz) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: ThemeHelper.roundBoxDeco(),
      child: Stack(
        children: [

        ],
      )
    );
  }
}