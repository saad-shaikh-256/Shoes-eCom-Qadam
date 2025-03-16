import 'package:Hisabi/Home-Screen/homeScreen.dart';
import 'package:Hisabi/Product-Screen/buyNow.dart';
import 'package:Hisabi/Product-Screen/cartScreen.dart';
import 'package:Hisabi/Product-Screen/productDetails.dart';
import 'package:Hisabi/Splash-Screen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  runApp(
    GetMaterialApp(
      home: homeScreen( )  ,
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
