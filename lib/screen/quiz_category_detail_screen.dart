import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:withbible_app/store/quiz_store.dart';
import 'package:withbible_app/common/theme_helper.dart';
import 'package:withbible_app/model/category.dart';
import 'package:withbible_app/model/quiz.dart';

class QuizCategoryDetailScreen extends StatefulWidget {
  static const routeName = '/categoryDetail';
  late Category category;

  QuizCategoryDetailScreen(this.category, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuizCategoryDetailScreenState(category);
}

class _QuizCategoryDetailScreenState extends State<QuizCategoryDetailScreen> {
  late Category category;

  _QuizCategoryDetailScreenState(this.category);

  late List<Quiz> quizList = [];

  @override
  void initState() {
    var quizStore = QuizStore();
    quizStore.loadQuizListByCategoryAsync(category.id).then((value) {
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
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.center,
        child: Column(
          children: [
            screenHeader(category),
            Expanded(
              child: categoryDetailView(quizList),
            ),
          ],
        ),
      ),
    ));
  }

  screenHeader(Category category) {
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
            "${category.name} Quiz",
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
            categoryDetailsItemBadge(quiz),
            Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: ThemeHelper.roundBoxDeco(
                            color: const Color(0xffE1E9F6), radius: 10),
                        child: Image(
                          image: AssetImage(category.imagePath),
                          width: 130,
                        )),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          quiz.title,
                          style: const TextStyle(fontSize: 22),
                        )
                      ],
                    ))
                  ],
                ))
          ],
        ));
  }
}
