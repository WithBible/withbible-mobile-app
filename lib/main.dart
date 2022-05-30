import 'package:flutter/material.dart';
import 'package:withbible_app/common/route_generator.dart';
import 'package:withbible_app/common/theme_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '위드바이블',
      theme: ThemeHelper.getThemeData(),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
