import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:withbible_app/api/api.dart';
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
import 'package:withbible_app/widget/disco_button.dart';
import 'package:withbible_app/widget/question_options_widget.dart';

class QuizScreen extends StatefulWidget {
  static const routeName = "/quiz";
  late Quiz quiz;

  QuizScreen(this.quiz, {Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState(quiz);
}

class _QuizScreenState extends State<QuizScreen> with WidgetsBindingObserver {
  late QuizEngine engine;
  late QuizStore store;
  late Api api;
  late Quiz quiz;
  Question? question;
  AppLifecycleState? state;
  late String name;

  Map<int, OptionSelection> _optionSerial = {};

  _QuizScreenState(this.quiz) {
    store = QuizStore();
    api = Api();
    engine = QuizEngine(quiz, onNextQuestion, onQuizComplete);
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _asyncMethod();
    });

    engine.start();
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  _asyncMethod() async{
    QuizStore.getName('name').then((name) {
      setState(() {
        name = name;
      });
    });
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
        decoration: BoxDecoration(color: ThemeHelper.shadowColor),
        padding: const EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              screenHeader(),
              quizQuestion(),
              questionOptions(),
              footerButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget screenHeader() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          GestureDetector(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: const FaIcon(
                FontAwesomeIcons.angleLeft,
                color: Color(0xff8d5ac4),
              ),
            ),
            onTap: () {
              setState(() {
                engine.stop();
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget quizQuestion() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: ThemeHelper.roundBoxDeco(color: ThemeHelper.primaryColor),
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
                engine.updateAnswer(
                    quiz.questions.indexOf(question!), optionIndex);

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
            ),
          );

          return optionWidget;
        }).toList(),
      ),
    );
  }

  Widget footerButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DiscoButton(
          onPressed: () {
            setState(() {
              engine.stop();
            });
            Navigator.pop(context);
          },
          child: const Text(
            "Cancel",
            style: TextStyle(color: Color(0xff8d5ac4), fontSize: 20),
          ),
          width: 130,
          height: 50,
        ),
        DiscoButton(
          onPressed: () {
            engine.next();
          },
          child: const Text(
            "Next",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          isActive: true,
          width: 130,
          height: 50,
        ),
      ],
    );
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
    store.getCategoryLocalAsync(quiz.categoryId).then((category) {
      api
          .saveQuizHistory(QuizHistory(
              "",
              category.id,
              quiz.title,
              "$total/${quiz.questions.length}",
              takenTime.format(),
              DateFormat.yMEd().add_jms().format(DateTime.now()),
              "Complete"))
          .then((value) {
        Navigator.pushReplacementNamed(context, QuizResultScreen.routeName,
            arguments: QuizResult(quiz, total));
      });
    });
  }
}
