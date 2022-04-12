import 'package:flutter/material.dart';
import 'package:withbible_app/common/extensions.dart';
import 'package:withbible_app/store/quiz_store.dart';
import 'package:withbible_app/common/theme_helper.dart';
import 'package:withbible_app/model/dto/option_selection.dart';
import 'package:withbible_app/model/option.dart';
import 'package:withbible_app/model/question.dart';
import 'package:withbible_app/model/quiz.dart';
import 'package:withbible_app/model/quiz_history.dart';
import 'package:withbible_app/model/quiz_result.dart';
import 'package:withbible_app/screen/quiz_result_screen.dart';
import 'package:withbible_app/service/quiz_engine.dart';
import 'package:withbible_app/widget/question_options_widget.dart';

class QuizScreen extends StatefulWidget {
  static const routeName = "/quiz";
  late Quiz quiz;

  QuizScreen(this.quiz, {Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState(quiz);
}

class _QuizScreenState extends State<QuizScreen> with WidgetsBindingObserver{
  late QuizEngine engine;
  late QuizStore store;
  late Quiz quiz;
  Question? question;
  AppLifecycleState? state;

  Map<int, OptionSelection> _optionSerial = {};

  _QuizScreenState(this.quiz) {
    store = QuizStore();
    engine = QuizEngine(quiz, onNextQuestion, onQuizComplete);
  }

  @override
  void initState() {
    engine.start();
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    this.state = state;
  }

  @override
  void dispose() {
    engine.stop();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
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
              onTap: () {
                setState(() {
                  engine.updateAnswer(quiz.questions.indexOf(question!), optionIndex);
                  for (int i = 0; i < _optionSerial.length; i++) {
                    _optionSerial[i]!.isSelected = false;
                  }
                  _optionSerial.update(optionIndex, (value) {
                    value.isSelected = true;
                    return value;
                  });
                });
              },
              child: QuestionOptionsWidget(
                optionIndex,
                _optionSerial[optionIndex]!.optionText,
                each.text,
                isSelected: _optionSerial[optionIndex]!.isSelected,
              )
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
        Navigator.pushReplacementNamed(context, QuizResultScreen.routeName,
            arguments: QuizResult(quiz, total));
      });
    });
  }
}
