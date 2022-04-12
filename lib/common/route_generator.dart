import 'package:flutter/material.dart';
import 'package:withbible_app/model/category.dart';
import 'package:withbible_app/model/quiz.dart';
import 'package:withbible_app/screen/home_screen.dart';
import 'package:withbible_app/screen/quiz_category_detail_screen.dart';
import 'package:withbible_app/screen/quiz_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case QuizScreen.routeName:
        if (args is Quiz) {
          return MaterialPageRoute(
            builder: (_) => QuizScreen(args),
          );
        }
        return _errorRoute();
      case QuizCategoryDetailScreen.routeName:
        if (args is Category) {
          return MaterialPageRoute(
            builder: (_) => QuizCategoryDetailScreen(args)
          );
        }
        return _errorRoute();
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
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
