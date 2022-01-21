import 'package:flutter/material.dart';
import 'package:my_blog/pages/crypto_list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: const Color(0xffbb86fc),
          secondary: const Color(0xffbb86fc),
        )
      ),
      debugShowCheckedModeBanner: false,
      home: CryptoListPage(),
    );
  }
}