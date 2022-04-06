import 'package:flutter/material.dart';
import 'package:withbible_app/page/home_page.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}