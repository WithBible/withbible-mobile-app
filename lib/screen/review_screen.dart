import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:withbible_app/common/theme_helper.dart';
import 'package:withbible_app/controller/quiz_history.dart';
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
  late Quiz quiz;
  Question? question;
  String questionAnswer = '';
  late List<String> answerSheet;

  _ReviewScreenState(this.quiz) {
    quiz = quiz;
  }

  @override
  void initState() {
    loadQuizHistoryByTitle(quiz.title).then((value) {
      setState(() {
        answerSheet = value!.answerSheet;
        questionAnswer = answerSheet.first;
      });
    });

    question = quiz.questions.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const double padding = 16;

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
          preferredSize: const Size.fromHeight(50),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: padding),
            child: QuestionNumbersWidget(
              questions: quiz.questions,
              question: question,
              onClickedNumber: (index) => nextQuestion(index),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: ThemeHelper.shadowColor),
        padding: const EdgeInsets.all(padding),
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
          final isSelected = option.code == questionAnswer;
          final reviewColor = getColorForOption(option, isSelected);

          var optionWidget = QuestionOptionsWidget(
            optionIndex,
            option.code,
            option.text,
            isSelected: isSelected,
            reviewColor: reviewColor,
          );

          return optionWidget;
        }).toList(),
      ),
    );
  }

  void nextQuestion(int index) {
    setState(() {
      question = quiz.questions[index];
      questionAnswer = answerSheet[index];
    });
  }

  Color getColorForOption(Option option, isSelected) {
    return isSelected
        ? option.isCorrect
            ? Colors.green
            : Colors.red
        : Colors.white;
  }
}
