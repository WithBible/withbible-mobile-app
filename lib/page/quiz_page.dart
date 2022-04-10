import 'package:flutter/material.dart';
import 'package:withbible_app/common/extensions.dart';
import 'package:withbible_app/common/quiz_store.dart';
import 'package:withbible_app/common/theme_helper.dart';
import 'package:withbible_app/model/dto/option_selection.dart';
import 'package:withbible_app/model/option.dart';
import 'package:withbible_app/model/question.dart';
import 'package:withbible_app/model/quiz.dart';
import 'package:withbible_app/model/quiz_history.dart';
import 'package:withbible_app/model/quiz_result.dart';
import 'package:withbible_app/page/quiz_result_page.dart';
import 'package:withbible_app/service/quiz_engine.dart';

class QuizPage extends StatefulWidget {
  static const routeName = "/quiz";
  late Quiz quiz;

  QuizPage(this.quiz, {Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState(quiz);
}

class _QuizPageState extends State<QuizPage> {
  late QuizEngine engine;
  late QuizStore store;
  late Quiz quiz;
  Question? question;

  Map<int, OptionSelection> _optionSerial = {};

  _QuizPageState(this.quiz) {
    store = QuizStore();
    engine = QuizEngine(quiz, onNextQuestion, onQuizComplete);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // screenHeader(),
            quizQuestion(),
            questionOptions(),
            // footerButton(),
          ],
        ),
      ),
    ));
  }

  Widget quizQuestion() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: ThemeHelper.roundBoxDeco(),
      child: Text(
        question?.text ?? "",
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Widget questionOptions() {
    return Container(
        alignment: Alignment.center,
        decoration: ThemeHelper.roundBoxDeco(),
        child: Column(
          children: List<Option>.from(question?.options ?? []).map((each) {
            int optionIndex = question!.options.indexOf(each);
            var optionWidget = GestureDetector(
              onTap: () {},
            );
            return optionWidget;
          }).toList(),
        ));
  }

  void onNextQuestion(Question question) {
    setState(() {
      this.question = question;
      _optionSerial = {};

      for (var i = 0; i < question.options.length; i++) {
        _optionSerial[i] = OptionSelection(String.fromCharCode(65 + i), false);
      }
    });
  }

  void onQuizComplete(Quiz quiz, double total, Duration takenTime) {
    store.getCategoryAsync(quiz.categoryId).then((category) {
      store
          .saveQuizHistory(QuizHistory(
              category.id,
              quiz.title,
              "$total/${quiz.questions.length}",
              takenTime.format(),
              DateTime.now(),
              "Complete"))
          .then((value) {
        Navigator.pushReplacementNamed(context, QuizResultPage.routeName,
            arguments: QuizResult(quiz, total));
      });
    });
  }
}
