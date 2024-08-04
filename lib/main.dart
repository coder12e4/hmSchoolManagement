import 'package:flutter/material.dart';
import 'package:hamonschoolmanagement/pages/student/DetailPage.dart';
import 'package:hamonschoolmanagement/pages/Home/HomePage.dart';

import 'core/theme/hamonthemes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme: ThemeOfapp.darkTheme,
        theme: ThemeOfapp.lightTheme,
        themeMode: ThemeMode.system,
        home: const HomePage());
  }
}
