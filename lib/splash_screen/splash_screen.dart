import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:symptocheck/home-screen/home_screen.dart';
import 'package:symptocheck/token.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "splash-screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool hasReceivedData = false;
  late List receivedData;

  String token = TOKEN;

  Future getData() async {
    final String url = "https://sandbox-healthservice.priaid.ch/symptoms?token=" + token + "&language=en-gb";
    final response = await http.get(Uri.parse(url));
    receivedData = json.decode(response.body);
    print(receivedData);
    hasReceivedData = true;
    if (hasReceivedData) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName, arguments: {"data": receivedData});
    }
    // if (response.body != "not found") {
    //   data = json.decode(response.body);
    //   if (data["type"] == "core") {
    //     final user = User(name: data["name"], email: data["email"], domain: data["domain"], type: data["type"], picture: pictureAddress);
    //     await UserDatabase.instance.create(user);

    //     Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    //   } else {
    //     final user = User(name: data["name"], email: data["email"], domain: data["domain"], type: data["type"], picture: pictureAddress);
    //     await UserDatabase.instance.create(user);

    //     Navigator.of(context).pushReplacementNamed(BoardHomeScreen.routeName);
    //   }
    // } else {
    //   await GoogleSignInApi.logout();
    //   Navigator.of(context).pushNamed(SignUpScreen.routeName);
    //}
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  height: 250,
                  child: Image.asset("assets/images/logo.png"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
