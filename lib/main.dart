import 'package:flutter/material.dart';
import 'package:withbible_app/model/category.dart';
import 'package:withbible_app/widget/questions_widget.dart';
import 'package:withbible_app/data/questions.dart';

void main() {
  runApp(QuestionsWidget(category: Category(questions: questions),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QuestionsWidget(
        category: widget.category,
      )
    );
  }
}
