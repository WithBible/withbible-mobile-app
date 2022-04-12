import 'package:flutter/material.dart';
import 'package:withbible_app/model/option.dart';
import 'package:withbible_app/model/question.dart';
import 'package:withbible_app/utils.dart';

class QuestionOptionsWidget extends StatelessWidget {
  int index;
  String optionText;
  String text;
  bool isSelected;
  // List<Option> options;

  // late ValueChanged<Option> onClickedOption;

  QuestionOptionsWidget(this.index, this.optionText, this.text,
      // this.options,
      {Key? key, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Row(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurple, width: 4),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.white),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    optionText,
                    style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                        fontSize: 30),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
