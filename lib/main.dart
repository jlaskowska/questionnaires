import 'package:flutter/material.dart';
import 'package:questionnaires/configs/app_colors.dart';
import 'package:questionnaires/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Color(AppColors.green),
        ),
        primaryColor: Color(AppColors.green),
        primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(color: Colors.white),
        primaryTextTheme: TextTheme(
          title: TextStyle(color: Colors.white),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
