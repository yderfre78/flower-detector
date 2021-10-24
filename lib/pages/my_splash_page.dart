import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import '../home.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: Home(),
      duration: 4000,
      imageSize: 150,
      imageSrc: "assets/cat.png",
      text: "Perro o Gato",
      textType: TextType.TyperAnimatedText,
      textStyle: TextStyle(
        fontSize: 30.0,
      ),
      backgroundColor: Colors.white,
    );
  }
}
