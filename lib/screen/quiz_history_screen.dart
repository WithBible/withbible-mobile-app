import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:withbible_app/api/api.dart';
import 'package:withbible_app/common/theme_helper.dart';
import 'package:withbible_app/model/quiz_history.dart';
import 'package:withbible_app/screen/review_screen.dart';
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
  late Api api;

  @override
  void initState() {
    store = QuizStore();
    api = Api();

    api.loadQuizHistoryAsync().then((value) {
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
        body: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(color: ThemeHelper.shadowColor),
          child: Column(
            children: [
              screenHeader(),
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
              Navigator.pop(context);
            },
          ),
          Text(
            "퀴즈 기록",
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
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
                    api
                        .getQuizByTitleAsync(quiz.title, quiz.categoryId)
                        .then((value) {
                      Navigator.pushReplacementNamed(
                          context, ReviewScreen.routeName,
                          arguments: value);
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
