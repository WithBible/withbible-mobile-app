import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:withbible_app/model/category.dart';

final categories = <Category>[
  Category(
      id: 1,
      name: '모세오경',
      backgroundColor: Colors.pink,
      imagePath: '/images/pentateuch.png',
      icon: FontAwesomeIcons.bookBible),
  Category(
      id: 2,
      name: '역사서',
      imagePath: '/images/pentateuch.png',
      icon: FontAwesomeIcons.landmark),
  Category(
      id: 3,
      name: '선지서',
      imagePath: '/images/pentateuch.png',
      icon: FontAwesomeIcons.handSparkles),
  Category(
      id: 4,
      name: '사복음서',
      backgroundColor: Colors.pink,
      imagePath: '/images/pentateuch.png',
      icon: FontAwesomeIcons.faceSmile),
  Category(
      id: 5,
      name: '사도행전',
      backgroundColor: Colors.pink,
      imagePath: '/images/pentateuch.png',
      icon: FontAwesomeIcons.church),
  Category(
      id: 6,
      name: '요한계시록',
      imagePath: '/images/pentateuch.png',
      icon: FontAwesomeIcons.personRays),
];
