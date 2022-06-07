import 'package:flutter/material.dart';
import 'package:withbible_app/common/theme_helper.dart';

class QuestionOptionsWidget extends StatelessWidget {
  int index;
  String code;
  String text;
  bool isSelected;
  Color reviewColor;

  QuestionOptionsWidget(this.index, this.code, this.text,
      {Key? key, this.isSelected = false, this.reviewColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ThemeHelper.roundBoxDeco(color: reviewColor),
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Row(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                buildCodeBorder(context),
                buildCode(context),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: buildText(context),
          ),
        ],
      ),
    );
  }

  Widget buildCodeBorder(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff8d5ac4), width: 4),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color:
            isSelected ? Theme.of(context).colorScheme.secondary : Colors.white,
      ),
    );
  }

  Widget buildCode(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        code,
        style: TextStyle(
          color: isSelected
              ? Colors.white
              : Theme.of(context).colorScheme.secondary,
          fontSize: 30,
        ),
      ),
    );
  }

  Widget buildText(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 25,
          color: Theme.of(context).colorScheme.secondary,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
