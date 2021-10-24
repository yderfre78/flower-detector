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
      imageSrc: "assets/flower.png",
      text: "DETECTOR DE FLORES",
      textType: TextType.TyperAnimatedText,
      textStyle: TextStyle(
        color: Colors.green.shade900,
        fontSize: 30.0,
      ),
      backgroundColor: Color(0xFF87C042),
    );
  }
}
