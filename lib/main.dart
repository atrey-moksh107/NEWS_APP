import 'package:api_project/view/splash_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: 'NewsApp',
    theme: ThemeData(primaryColor: Colors.white, // Set the primary color
  ),
  debugShowCheckedModeBanner: false,
  home: SplashScreen(),
  );
  }

}