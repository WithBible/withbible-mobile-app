import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:withbible_app/api/api.dart';
import 'package:withbible_app/common/theme_helper.dart';
import 'package:withbible_app/model/option.dart';
import 'package:withbible_app/model/question.dart';
import 'package:withbible_app/model/quiz.dart';
import 'package:withbible_app/widget/question_numbers_widget.dart';
import 'package:withbible_app/widget/question_options_widget.dart';

class ReviewScreen extends StatefulWidget {
  static const routeName = "/review";
  late Quiz quiz;

  ReviewScreen(this.quiz, {Key? key}) : super(key: key);

  @override
  _ReviewScreenState createState() => _ReviewScreenState(quiz);
}

class _ReviewScreenState extends State<ReviewScreen> {
  late PageController controller;
  late Api api;
  late Quiz quiz;
  Question? question;
  String questionAnswer = '';
  late List<String> answerSheet;

  _ReviewScreenState(this.quiz) {
    quiz = quiz;
    question = quiz.questions.first;
  }

  @override
  void initState() {
    controller = PageController();
    api = Api();

    api.loadQuizHistoryByTitleAsync(quiz.title).then((value) {
      setState(() {
        answerSheet = value!.answerSheet;
        questionAnswer = answerSheet.first;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: QuestionNumbersWidget(
              questions: quiz.questions,
              question: quiz.questions.first,
              onClickedNumber: (index) => nextQuestion(index, jump: true),
            ),
          ),
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

          var optionWidget = QuestionOptionsWidget(
            optionIndex,
            option.code,
            option.text,
            isSelected: option.code == questionAnswer,
          );

          return optionWidget;
        }).toList(),
      ),
    );
  }

  void nextQuestion(int index, {bool jump = false}) {
    setState(() {
      question = quiz.questions[index];
      questionAnswer = answerSheet[index];
    });

    if (jump) {
      controller.jumpToPage(index);
    }
  }
}
