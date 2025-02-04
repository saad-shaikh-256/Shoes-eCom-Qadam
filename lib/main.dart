import 'package:flutter/material.dart';
import 'package:flutter_project/Splash-Screen/splashScreen.dart';
import 'package:flutter_project/Splash-Screen/startupScreen.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      home: Startupscreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Startupscreen(),
    );
  }
}
