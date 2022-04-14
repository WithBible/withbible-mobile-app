import 'dart:math';

import 'package:withbible_app/model/question.dart';
import 'package:withbible_app/model/quiz.dart';

typedef OnQuizNext = void Function(Question question);
typedef OnQuizCompleted = void Function(Quiz quiz, double totalCorrect, Duration takenTime);

class QuizEngine {
  int questionIndex = 0;
  bool isRunning = false;
  bool takeNewQuestion = true;
  DateTime quizStartTime = DateTime.now();

  Quiz quiz;
  List<int> takenQuestions = [];
  Map<int, bool> questionAnswer = {};

  OnQuizNext onNext;
  OnQuizCompleted onCompleted;

  QuizEngine(this.quiz, this.onNext, this.onCompleted);

  void start() {
    questionIndex = 0;
    questionAnswer = {};
    takenQuestions = [];
    questionAnswer = {};
    isRunning = true;
    takeNewQuestion = true;

    Future.doWhile(() async {
      Question? question;
      quizStartTime = DateTime.now();

      do {
        if (takeNewQuestion) {
          question = _nextQuestion(quiz, questionIndex);

          if (question != null) {
            takeNewQuestion = false;
            questionIndex++;
            onNext(question);
          }
        }
        if(question == null || quiz.questions.length == questionAnswer.length){
          double totalCorrect = 0.0;

          questionAnswer.forEach((key, value){
            if(value == true){
              totalCorrect++;
            }
          });
          var takenTime = quizStartTime.difference(DateTime.now());
          onCompleted(quiz, totalCorrect, takenTime);
        }
        await Future.delayed(const Duration(milliseconds: 500));
      } while (question != null && isRunning);
      return false;
    });
  }

  void stop(){
    takeNewQuestion = false;
    isRunning = false;
  }

  void next(){
    takeNewQuestion = true;
  }

  void updateAnswer(int questionIndex, int answer) {
    var question = quiz.questions[questionIndex];
    questionAnswer[questionIndex] = question.options[answer].isCorrect;
  }

  Question? _nextQuestion(Quiz quiz, int index) {
    while (true) {
      if (takenQuestions.length >= quiz.questions.length) {
        return null;
      }
      if (quiz.shuffleQuestions) {
        index = Random().nextInt(quiz.questions.length);

        if (takenQuestions.contains(index) == false) {
          takenQuestions.add(index);
          return quiz.questions[index];
        }
      } else {
        return quiz.questions[index];
      }
    }
  }
}
