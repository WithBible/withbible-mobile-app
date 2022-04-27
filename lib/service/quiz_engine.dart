import 'dart:math';
import 'package:stack/stack.dart';
import 'package:withbible_app/model/option.dart';

import 'package:withbible_app/model/question.dart';
import 'package:withbible_app/model/quiz.dart';

typedef OnQuizPrev = void Function(Question question, String prevSelectCode);
typedef OnQuizNext = void Function(Question question, String prevSelectCode);
typedef OnQuizCancel = void Function();
typedef OnQuizCompleted = void Function(
    Quiz quiz, double totalCorrect, Duration takenTime);

class QuizEngine {
  bool isRunning = false;
  bool takePrevQuestion = false;
  bool takeNewQuestion = true;
  DateTime quizStartTime = DateTime.now();

  Map<int, Option> questionAnswer = {};
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
        if (takePrevQuestion) {
          takenQuestions.pop();

          if (takenQuestions.isEmpty) {
            onCancel();
          } else {
            int prevIndex = takenQuestions.top();
            question = quiz.questions[prevIndex];

            if (questionAnswer[prevIndex] != null) {
              onPrev(question, questionAnswer[prevIndex]!.code);
            } else {
              onPrev(question, "I NEED OVERLOADING!");
            }

            takePrevQuestion = false;
          }
        }

        if (takeNewQuestion) {
          question = _selectNextQuestion(quiz);
          int curIndex = takenQuestions.top();

          if (question != null) {
            if (questionAnswer[curIndex] != null) {
              onNext(question, questionAnswer[curIndex]!.code);
            } else {
              onNext(question, "I NEED OVERLOADING!");
            }

            takeNewQuestion = false;
          }
        }

        if (question == null ||
            quiz.questions.length == questionAnswer.length) {
          double totalCorrect = 0.0;

          questionAnswer.forEach((key, value) {
            if (value.isCorrect == true) {
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
    questionAnswer[questionIndex] = question.options[answer];
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
