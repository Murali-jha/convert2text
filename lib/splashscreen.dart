import 'package:flutter/material.dart';
import 'package:image_to_text/homepage.dart';
import 'package:splashscreen/splashscreen.dart';


class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: HomePage(),
      image: Image.asset("assets/imagetext.png"),
      photoSize: 100.0,
      backgroundColor: Colors.black12,
      loaderColor: Colors.white,
      loadingText: Text(
        "DevCafe",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0
        ),
      ),
    );
  }
}
