import 'package:flutter/material.dart';
import 'UI/HomePage.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API Fetch Test',
      home: MyHomePage(),
    );
  }
}