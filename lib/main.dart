import 'package:flutter/material.dart';
import 'package:withbible_app/data/categories.dart';
import 'package:withbible_app/page/category_page.dart';
import 'package:withbible_app/page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '위드바이블',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: HomePage(),
    );
  }
}
