import 'package:withbible_app/model/category.dart';
import 'package:withbible_app/data/questions.dart';

final categories = <Category>[
  Category(
      questions: questions,
      categoryName: '모세오경',
      imageUrl: 'assets/pentateuch.png'),

  Category(
      questions: questions,
      categoryName: '역사서',
      imageUrl: 'assets/pentateuch.png'),
];
