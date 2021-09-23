import 'package:flutter/material.dart';
import 'package:my_blog/pages/posts_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PostsPage(),
    );
  }
}