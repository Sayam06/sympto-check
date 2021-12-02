import 'package:flutter/material.dart';
import 'package:symptocheck/details_screen/details_screen.dart';
import 'package:symptocheck/home-screen/home_screen.dart';
import 'package:symptocheck/results/results_screen.dart';
import 'package:symptocheck/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: SplashScreen(),
      routes: {
        SplashScreen.routeName: (ctx) => SplashScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        ResultsScreen.routeName: (ctx) => ResultsScreen(),
        DetailsScreen.routeName: (ctx) => DetailsScreen(),
      },
    );
  }
}
