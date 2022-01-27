import 'package:flutter/material.dart';
import 'package:my_blog/pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          onPrimary: Colors.white,
          onSecondary: Colors.white,
        )
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}