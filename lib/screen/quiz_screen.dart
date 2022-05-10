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

  Map<int, OptionSelection> _optionSerial = {};

  _QuizScreenState(this.quiz) {
    store = QuizStore();
    api = Api();
    engine = QuizEngine(
        quiz, onPrevQuestion, onNextQuestion, onQuizCancel, onQuizComplete);
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
      backgroundColor: ThemeHelper.shadowColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeHelper.shadowColor,
        leading: IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.angleLeft,
            color: Color(0xff8d5ac4),
          ),
          onPressed: () {
            setState(() {
              engine.stop();
            });
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildQuizQuestion(),
              buildOptions(),
              buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQuizQuestion() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.centerLeft,
      decoration: ThemeHelper.roundBoxDeco(color: ThemeHelper.primaryColor),
      child: Text(
        question?.text ?? "",
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Widget buildOptions() {
    return Container(
      alignment: Alignment.center,
      decoration: ThemeHelper.roundBoxDeco(),
      child: Column(
        children: List<Option>.from(question?.options ?? []).map((option) {
          int optionIndex = question!.options.indexOf(option);

          var optionWidget = GestureDetector(
            onTap: () {
              setState(() {
                engine.updateAnswer(
                  quiz.questions.indexOf(question!),
                  optionIndex,
                );

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
              _optionSerial[optionIndex]!.code,
              option.text,
              isSelected: _optionSerial[optionIndex]!.isSelected,
            ),
          );

          return optionWidget;
        }).toList(),
      ),
    );
  }

  Widget buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DiscoButton(
          onPressed: () {
            engine.prev();
          },
          child: const Text(
            "Prev",
            style: TextStyle(color: Color(0xfffbce7b), fontSize: 20),
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

  void onNextQuestion(Question question, String prevSelectCode) {
    setState(() {
      this.question = question;
      _optionSerial = {};

      for (var i = 0; i < question.options.length; i++) {
        String code = String.fromCharCode(65 + i);

        if (code == prevSelectCode) {
          _optionSerial[i] = OptionSelection(prevSelectCode, true);
          continue;
        }
        _optionSerial[i] = OptionSelection(code, false);
      }
    });
  }

  void onPrevQuestion(Question question, String prevSelectCode) {
    setState(() {
      this.question = question;
      _optionSerial = {};

      for (var i = 0; i < question.options.length; i++) {
        String code = String.fromCharCode(65 + i);

        if (code == prevSelectCode) {
          _optionSerial[i] = OptionSelection(prevSelectCode, true);
          continue;
        }
        _optionSerial[i] = OptionSelection(code, false);
      }
    });
  }

  void onQuizCancel() {
    setState(() {
      engine.stop();
    });
    Navigator.pop(context);
  }

  void onQuizComplete(
      Quiz quiz, double total, Duration takenTime, List<String> answerSheet) {
    Future nameFuture = QuizStore.getName('name');
    Future categoryFuture = store.getCategoryLocalAsync(quiz.categoryId);
    Future historyFuture = api.loadQuizHistoryByTitleAsync(quiz.title);

    Future.wait([nameFuture, categoryFuture, historyFuture]).then((value) {
      String name = value[0];
      int categoryId = value[1].id;
      String? score = value[2]?.score;

      score == null
          ? api.saveQuizHistory(
              QuizHistory(
                name,
                categoryId,
                quiz.title,
                answerSheet,
                "$total/${quiz.questions.length}",
                takenTime.format(),
                DateFormat.yMEd().add_jms().format(DateTime.now()),
                "Complete",
              ),
            )
          : api.updateQuizHistory(
              QuizHistory(
                name,
                categoryId,
                quiz.title,
                answerSheet,
                "$total/${quiz.questions.length}",
                takenTime.format(),
                DateFormat.yMEd().add_jms().format(DateTime.now()),
                "Complete",
              ),
            );

      // TODO: Need inside then after saveQuizHistory
      Navigator.pushReplacementNamed(
        context,
        QuizResultScreen.routeName,
        arguments: QuizResult(quiz, total),
      );
    });
  }
}
