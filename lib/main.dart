import 'package:cat_and_dog_predictor/pages/my_splash_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cat vs Dog',
      home: MySplashScreen(),
    );
  }
}
