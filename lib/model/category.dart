import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category {
  late int id;
  late String name;
  late Color backgroundColor;
  late IconData icon;

  Category({
    this.id = 0,
    this.name = '',
    this.backgroundColor = const Color(0xfffbce7b),
    this.icon = FontAwesomeIcons.question,
  });
}
