import '../model/question.dart';
import '../model/option.dart';

final questions = [
  Question(
      text: '소돔과 고모라성이 멸망당할 때 롯의 가족은 천사의 이끌림을 받아 구원받았다. 롯의 아내는 뒤를 돌아보지 말라는 약속을 어기고 뒤를 돌아보아서 무엇이 되었는가?', 
      options: [
        Option(code: 'A', text: '소금기둥', isCorrect: true),
        Option(code: 'B', text: '돌기둥', isCorrect: false),
        Option(code: 'C', text: '구름기둥', isCorrect: false),
        Option(code: 'D', text: '기둥', isCorrect: false),
      ],
  ),
  Question(
    text: '창 6: 9에 기록된 노아에 대한 설명 중 옳지 않은 것은 어느것인가?',
    options: [
      Option(code: 'A', text: '지혜로운 자', isCorrect: true),
      Option(code: 'B', text: '의인', isCorrect: false),
      Option(code: 'C', text: '하나님과 동행하는 자', isCorrect: false),
      Option(code: 'D', text: '완전한 자', isCorrect: false),
    ],
  ),
];