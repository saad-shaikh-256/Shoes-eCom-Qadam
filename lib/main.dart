import 'package:Hisabi/Splash-Screen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:Hisabi/Home-Screen/homeScreen.dart';


void main() async {
    runApp(
    GetMaterialApp(
      home: homeScreen(),
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
      home: SplashScreen(),
    );
  }
}
