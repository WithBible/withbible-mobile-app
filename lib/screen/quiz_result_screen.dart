import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:withbible_app/common/theme_helper.dart';
import 'package:withbible_app/model/quiz_result.dart';
import 'package:withbible_app/screen/quiz_history_screen.dart';
import 'package:withbible_app/widget/disco_button.dart';

class QuizResultScreen extends StatefulWidget {
  static const routeName = "/quizResult";
  QuizResult result;

  QuizResultScreen(this.result, {Key? key}) : super(key: key);

  @override
  _QuizResultScreenState createState() => _QuizResultScreenState(this.result);
}

class _QuizResultScreenState extends State<QuizResultScreen>{
  QuizResult result;
  int totalQuestions = 0;
  double totalCorrect = 0;

  _QuizResultScreenState(this.result);

  @override
  void initState() {
    setState(() {
      totalCorrect = result.totalCorrect;
      totalQuestions = result.quiz.questions.length;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: ThemeHelper.shadowColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            quizResultInfo(result),
            bottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget bottomButtons() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DiscoButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Close",
              style: TextStyle(color: Color(0xff8d5ac4), fontSize: 20),
            ),
            width: 150,
            height: 50,
          ),
          DiscoButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, QuizHistoryScreen.routeName);
            },
            child: const Text(
              "History",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            width: 150,
            height: 50,
            isActive: true,
          ),
        ],
      ),
    );
  }

  Widget quizResultInfo(QuizResult result) {
    return Column(
      children: [
        Text(
          "축하합니다!",
          style: Theme.of(context).textTheme.headline3,
        ),
        Text(
          "당신의 점수는",
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(
          "$totalCorrect/$totalQuestions",
          style: Theme.of(context).textTheme.headline2,
        ),
      ],
    );
  }
}