import 'package:flutter/material.dart';
import 'package:withbible_app/common/theme_helper.dart';
import 'package:withbible_app/model/question.dart';

class QuestionNumbersWidget extends StatelessWidget {
  final List<Question> questions;
  final Question question;
  final ValueChanged<int> onClickedNumber;

  const QuestionNumbersWidget({
    Key? key,
    required this.questions,
    required this.question,
    required this.onClickedNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double padding = 16;

    return SizedBox(
      height: 50,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: padding),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => Container(
          width: padding,
        ),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final isSelected = question == questions[index];
          return buildNumber(context, index, isSelected);
        },
      ),
    );
  }

  Widget buildNumber(BuildContext context, int index, bool isSelected) {
    final color = isSelected ? ThemeHelper.primaryColor : Colors.white;

    return GestureDetector(
        onTap: () => onClickedNumber(index),
        child: CircleAvatar(
          backgroundColor: color,
          child: Text(
            '${index + 1}',
            style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ));
  }
}
