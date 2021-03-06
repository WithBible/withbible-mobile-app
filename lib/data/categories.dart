import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:withbible_app/common/theme_helper.dart';
import 'package:withbible_app/model/category.dart';

final categories = <Category>[
  Category(
      id: 1,
      name: '모세오경',
      backgroundColor: ThemeHelper.accentColor,
      icon: FontAwesomeIcons.bookBible),
  Category(
      id: 2,
      name: '역사서',
      icon: FontAwesomeIcons.landmark),
  Category(
      id: 3,
      name: '선지서',
      backgroundColor: ThemeHelper.accentColor,
      icon: FontAwesomeIcons.handSparkles),
  Category(
      id: 4,
      name: '사복음서',
      icon: FontAwesomeIcons.faceSmile),
  Category(
      id: 5,
      name: '사도행전',
      backgroundColor: ThemeHelper.accentColor,
      icon: FontAwesomeIcons.church),
  Category(
      id: 6,
      name: '요한계시록',
      icon: FontAwesomeIcons.personRays),
];
