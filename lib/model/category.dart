import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category {
  final String id;
  final String name;
  final String description;
  final Color backgroundColor;
  final IconData icon;
  final String imagePath;

  Category({
    this.id = '',
    required this.imagePath,
    required this.name,
    this.description = '',
    this.backgroundColor = const Color(0xff20aebe),
    this.icon = FontAwesomeIcons.question,
  });
}