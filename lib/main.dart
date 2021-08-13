import 'package:flutter/material.dart';
import 'package:image_to_text/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        textSelectionColor: Colors.deepOrangeAccent,
      ),
      title: 'Image to text',
      home: MySplashScreen(),
    );
  }
}
