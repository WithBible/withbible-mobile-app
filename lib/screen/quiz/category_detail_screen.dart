import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:withbible_app/common/theme_helper.dart';
import 'package:withbible_app/controller/quiz.dart';
import 'package:withbible_app/model/category.dart';
import 'package:withbible_app/model/quiz.dart';
import 'package:withbible_app/screen/quiz/quiz_screen.dart';

class QuizCategoryDetailScreen extends StatefulWidget {
  static const routeName = '/categoryDetail';
  late Category category;

  QuizCategoryDetailScreen(this.category, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _QuizCategoryDetailScreenState(category);
}

class _QuizCategoryDetailScreenState extends State<QuizCategoryDetailScreen> {
  late Category category;

  _QuizCategoryDetailScreenState(this.category);

  late List<Quiz> quizList = [];

  @override
  void initState() {
    loadQuizListByCategory(category.id).then((value) {
      setState(() {
        quizList = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ThemeHelper.shadowColor,
          leading: IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: Color(0xff8d5ac4),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          decoration: BoxDecoration(color: ThemeHelper.shadowColor),
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Column(
            children: [
              Expanded(
                child: buildCategoryDetails(quizList),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategoryDetails(List<Quiz> quizList) {
    return SingleChildScrollView(
      child: Column(
        children: quizList
            .map((quiz) => GestureDetector(
                  child: buildCategoryDetailItem(quiz),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      QuizScreen.routeName,
                      arguments: quiz,
                    );
                  },
                ))
            .toList(),
      ),
    );
  }

  buildCategoryDetailItem(Quiz quiz) {
    return Container(
      decoration: ThemeHelper.roundBoxDeco(),
      margin: const EdgeInsets.only(bottom: 20),
      alignment: Alignment.centerLeft,
      child: Stack(
        children: [
          buildQuestionSizeBadge(quiz),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                buildCategoryIcon(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quiz.title,
                        style: const TextStyle(
                            color: Color(0xff8d5ac4),
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  buildCategoryIcon() {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: ThemeHelper.roundBoxDeco(
        color: ThemeHelper.accentColor,
        radius: 10,
      ),
      child: FaIcon(category.icon, color: Colors.white, size: 36),
    );
  }

  buildQuestionSizeBadge(Quiz quiz) {
    return Container(
      alignment: Alignment.topRight,
      child: Container(
        width: 150,
        decoration: BoxDecoration(
            color: ThemeHelper.accentColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            )),
        alignment: Alignment.center,
        child: Text(
          "${quiz.questions.length} Questions",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
