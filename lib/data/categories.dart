import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:withbible_app/model/category.dart';
import 'package:withbible_app/data/questions.dart';

final categories = <Category>[
  Category(
    questions: questions,
    categoryName: '모세오경',
    backgroundColor: Colors.pink,
    imageUrl: 'assets/pentateuch.png',
    icon: FontAwesomeIcons.bookBible
  ),
  Category(
    questions: questions,
    categoryName: '역사서',
    imageUrl: 'assets/pentateuch.png',
    icon: FontAwesomeIcons.landmark
  ),
  Category(
      questions: questions,
      categoryName: '선지서',
      imageUrl: 'assets/pentateuch.png',
      icon: FontAwesomeIcons.handSparkles
  ),
  Category(
      questions: questions,
      categoryName: '사복음서',
      backgroundColor: Colors.pink,
      imageUrl: 'assets/pentateuch.png',
      icon: FontAwesomeIcons.faceSmile
  ),
  Category(
      questions: questions,
      categoryName: '사도행전',
      backgroundColor: Colors.pink,
      imageUrl: 'assets/pentateuch.png',
      icon: FontAwesomeIcons.church
  ),
  Category(
      questions: questions,
      categoryName: '요한계시록',
      imageUrl: 'assets/pentateuch.png',
      icon: FontAwesomeIcons.personRays
  ),
];
