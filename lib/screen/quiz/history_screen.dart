import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:withbible_app/common/theme_helper.dart';
import 'package:withbible_app/controller/quiz.dart';
import 'package:withbible_app/controller/quiz_history.dart';
import 'package:withbible_app/model/quiz_history.dart';
import 'package:withbible_app/screen/quiz/review_screen.dart';
import 'package:withbible_app/store/quiz_store.dart';
import 'package:withbible_app/widget/disco_button.dart';

class QuizHistoryScreen extends StatefulWidget {
  static const routeName = '/quizHistory';

  const QuizHistoryScreen({Key? key}) : super(key: key);

  @override
  _QuizHistoryScreenState createState() => _QuizHistoryScreenState();
}

class _QuizHistoryScreenState extends State<QuizHistoryScreen> {
  List<QuizHistory> quizHistoryList = [];
  late QuizStore store;

  @override
  void initState() {
    store = QuizStore();
    loadQuizHistory().then((value) {
      setState(() {
        quizHistoryList = value;
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
          title: const Text('퀴즈 기록'),
          leading: IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: Colors.white,
            ),
            onPressed: () {
              // TODO: Need after quiz, No need before quiz
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(color: ThemeHelper.shadowColor),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List<QuizHistory>.from(quizHistoryList)
                        .map(
                          (each) => quizHistoryViewItem(each),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget quizHistoryViewItem(QuizHistory quiz) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(10),
      decoration: ThemeHelper.roundBoxDeco(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 10),
            child: SizedBox(
              height: 115,
              width: 10,
              child: Container(
                decoration: ThemeHelper.roundBoxDeco(
                    color: ThemeHelper.primaryColor, radius: 10),
              ),
            ),
          ),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                quiz.title.isEmpty ? "Question" : quiz.title,
                style: const TextStyle(fontSize: 24),
              ),
              Text("Score: ${quiz.score}",
                  style:
                      TextStyle(color: ThemeHelper.accentColor, fontSize: 18)),
              Text("Time Taken: ${quiz.timeTaken}"),
              Text("Date: ${quiz.date}"),
            ]),
          ),
          Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              DiscoButton(
                  width: 100,
                  height: 50,
                  onPressed: () {
                    getQuizByTitle(quiz.title, quiz.categoryId).then((quiz) {
                      Navigator.of(context).pushNamed(
                        QuizReviewScreen.routeName,
                        arguments: quiz,
                      );
                    });
                  },
                  child: const Text("Review")),
            ],
          )
        ],
      ),
    );
  }
}
