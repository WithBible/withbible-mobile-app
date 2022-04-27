import 'dart:math';
import 'package:stack/stack.dart';

import 'package:withbible_app/model/question.dart';
import 'package:withbible_app/model/quiz.dart';

typedef OnQuizPrev = void Function(Question question);
typedef OnQuizNext = void Function(Question question);
typedef OnQuizCancel = void Function();
typedef OnQuizCompleted = void Function(
    Quiz quiz, double totalCorrect, Duration takenTime);

class QuizEngine {
  bool isRunning = false;
  bool takePrevQuestion = false;
  bool takeNewQuestion = true;
  DateTime quizStartTime = DateTime.now();

  Map<int, bool> questionAnswer = {};
  Stack<int> takenQuestions = Stack();

  Quiz quiz;
  OnQuizPrev onPrev;
  OnQuizNext onNext;
  OnQuizCancel onCancel;
  OnQuizCompleted onCompleted;

  QuizEngine(
    this.quiz,
    this.onPrev,
    this.onNext,
    this.onCancel,
    this.onCompleted,
  );

  void start() {
    isRunning = true;
    takePrevQuestion = false;
    takeNewQuestion = true;

    takenQuestions = Stack();
    questionAnswer = {};

    Future.doWhile(() async {
      Question? question;
      quizStartTime = DateTime.now();

      do {
        print(takenQuestions.length);

        if (takePrevQuestion) {
          int prevIndex = takenQuestions.pop();
          question = quiz.questions[prevIndex];

          takePrevQuestion = false;
          onPrev(question);
        }

        if (takeNewQuestion) {
          question = _selectNextQuestion(quiz);

          if (question != null) {
            takeNewQuestion = false;
            onNext(question);
          }
        }

        if (takenQuestions.length <= 0) {
          onCancel();
        }

        if (question == null ||
            quiz.questions.length == questionAnswer.length) {
          double totalCorrect = 0.0;

          questionAnswer.forEach((key, value) {
            if (value == true) {
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

  void stop() {
    takePrevQuestion = false;
    takeNewQuestion = false;
    isRunning = false;
  }

  void prev() {
    takePrevQuestion = true;
    takeNewQuestion = false;
  }

  void next() {
    takePrevQuestion = false;
    takeNewQuestion = true;
  }

  void updateAnswer(int questionIndex, int answer) {
    var question = quiz.questions[questionIndex];
    questionAnswer[questionIndex] = question.options[answer].isCorrect;
  }

  Question? _selectNextQuestion(Quiz quiz) {
    while (true) {
      if (takenQuestions.length >= quiz.questions.length) {
        return null;
      }

      if (quiz.shuffleQuestions) {
        int index = Random().nextInt(quiz.questions.length);

        if (takenQuestions.contains(index) == false) {
          takenQuestions.push(index);
          return quiz.questions[index];
        }
      }
    }
  }
}
