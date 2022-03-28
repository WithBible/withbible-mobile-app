import 'package:flutter/material.dart';
import 'package:withbible_app/model/category.dart';
import 'package:withbible_app/widget/questions_widget.dart';
import 'package:withbible_app/data/questions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '위드바이블',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: QuestionsWidget(category: Category(questions: questions),)
    );
  }
}
