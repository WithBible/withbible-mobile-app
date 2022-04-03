import 'package:flutter/material.dart';
import 'package:withbible_app/model/category.dart';
import 'package:withbible_app/model/option.dart';
import 'package:withbible_app/model/question.dart';
import 'package:withbible_app/widget/questions_widget.dart';

class CategoryPage extends StatefulWidget {
  final Category category;

  const CategoryPage({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late PageController controller;
  late Question question;

  @override
  void initState() {
    super.initState();

    controller = PageController();
    question = widget.category.questions.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: QuestionsWidget(
      category: widget.category,
      controller: controller,
      onChangedPage: (index) => nextQuestion(index: index),
      onClickedOption: selectOption,
    ));
  }

  void selectOption(Option option) {
    if (question.isLocked) {
      return;
    } else {
      setState(() {
        question.isLocked = true;
        question.selectedOption = option;
      });
    }
  }

  void nextQuestion({required int index}) {
    final indexPage = index;

    setState(() {
      question = widget.category.questions[indexPage];
    });
  }
}
