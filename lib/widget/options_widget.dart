import 'package:flutter/material.dart';
import 'package:withbible_app/model/option.dart';
import 'package:withbible_app/model/question.dart';
import 'package:withbible_app/utils.dart';

class OptionsWidget extends StatelessWidget {
  final Question question;

  // final ValueChanged<Option> onClickedOption;

  const OptionsWidget({
    Key? key,
    required this.question,
    // required this.onClickedOption
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        physics: const BouncingScrollPhysics(),
        children: Utils.heightBetween(
            question.options
                .map((option) => buildOption(context, option))
                .toList(),
            height: 8));
  }

  Widget buildOption(BuildContext context, Option option) {
    return GestureDetector(
        // onTap: () => onClickedOption(option),
        child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
      ),
      child: buildAnswer(option),
    ));
  }

  Widget buildAnswer(option) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Text(option.code,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 12),
          Text(
            option.text,
            style: const TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }
}
