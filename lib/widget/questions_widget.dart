import 'package:flutter/material.dart';
import 'package:withbible_app/model/question.dart';
import 'package:withbible_app/model/category.dart';

class QuestionsWidget extends StatelessWidget{
  final Category category;

  const QuestionsWidget({
    Key? key,
    required this.category
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: category.questions.length,
      itemBuilder: (context, index){
        final question = category.questions[index];

        return buildQuestion(question: question);
      },
    );
  }

  Widget buildQuestion({required Question question}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text(
          question.text,
          style: const TextStyle(fontWeight: FontWeight.bold),
          textDirection: TextDirection.ltr,
        )
      ],
    );
  }

}