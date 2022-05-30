import 'package:flutter/material.dart';
import 'package:withbible_app/model/category.dart';
import 'package:withbible_app/model/quiz.dart';
import 'package:withbible_app/model/quiz_result.dart';
import 'package:withbible_app/screen/auth/login_screen.dart';
import 'package:withbible_app/screen/auth/register_screen.dart';
import 'package:withbible_app/screen/home_screen.dart';
import 'package:withbible_app/screen/quiz/category_detail_screen.dart';
import 'package:withbible_app/screen/quiz/history_screen.dart';
import 'package:withbible_app/screen/quiz/result_screen.dart';
import 'package:withbible_app/screen/quiz/quiz_screen.dart';
import 'package:withbible_app/screen/quiz/review_screen.dart';
import 'package:withbible_app/screen/splash_screen.dart';
import 'package:withbible_app/widget/bottom_widget.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RegisterScreen.routeName:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case BottomWidget.routeName:
        return MaterialPageRoute(builder: (_) => const BottomWidget());
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case QuizScreen.routeName:
        if (args is Quiz) {
          return MaterialPageRoute(
            builder: (_) => QuizScreen(args),
          );
        }
        return _errorRoute();
      case QuizResultScreen.routeName:
        if (args is QuizResult) {
          return MaterialPageRoute(
            builder: (_) => QuizResultScreen(args),
          );
        }
        return _errorRoute();
      case QuizHistoryScreen.routeName:
        return MaterialPageRoute(builder: (_) => const QuizHistoryScreen());
      case QuizCategoryDetailScreen.routeName:
        if (args is Category) {
          return MaterialPageRoute(
              builder: (_) => QuizCategoryDetailScreen(args));
        }
        return _errorRoute();
      case QuizReviewScreen.routeName:
        if (args is Quiz) {
          return MaterialPageRoute(
            builder: (_) => QuizReviewScreen(args),
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
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
