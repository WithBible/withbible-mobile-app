import 'package:flutter/material.dart';
import 'package:withbible_app/common/quiz_store.dart';
import 'package:withbible_app/common/theme_helper.dart';
import 'package:withbible_app/model/dto/option_selection.dart';
import 'package:withbible_app/model/option.dart';
import 'package:withbible_app/model/question.dart';
import 'package:withbible_app/model/quiz.dart';
import 'package:withbible_app/widget/questions_widget.dart';

class QuizPage extends StatefulWidget {
  static const routeName = "/question";
  late Quiz quiz;

  QuizPage({Key? key}) : super(key: key);

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
        )
    );
  }
}
