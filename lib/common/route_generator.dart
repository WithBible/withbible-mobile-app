import 'package:flutter/material.dart';
import 'package:withbible_app/model/category.dart';
import 'package:withbible_app/model/quiz.dart';
import 'package:withbible_app/page/home_page.dart';
import 'package:withbible_app/page/quiz_category_detail_page.dart';
import 'package:withbible_app/page/quiz_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case QuizPage.routeName:
        if (args is Quiz) {
          return MaterialPageRoute(
            builder: (_) => QuizPage(args),
          );
        }
        return _errorRoute();
      case QuizCategoryDetailPage.routeName:
        if (args is Category) {
          return MaterialPageRoute(
            builder: (_) => QuizCategoryDetailPage(args)
          );
        }
        return _errorRoute();
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
              child: Text(
            'ERROR: Please try again.',
            style: TextStyle(fontSize: 32),
          )));
    });
  }
}
