import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category {
  final int id;
  final String name;
  final String description;
  final Color backgroundColor;
  final IconData icon;
  final String imagePath;

  Category({
    this.id = 0,
    required this.imagePath,
    required this.name,
    this.description = '',
    this.backgroundColor = const Color(0xfffbce7b),
    this.icon = FontAwesomeIcons.question,
  });
}