import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:symptocheck/results/result_tiles.dart';
import 'dart:convert';

import 'package:symptocheck/token.dart';

class ResultsScreen extends StatefulWidget {
  static const routeName = "/results";

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  int counter = 0;

  late List selectedSymptoms;
  late List receivedData;

  late String year;
  late String gender;
  String token = TOKEN;

  List symptoms = [];

  void processSymptoms() {
    for (int i = 0; i < selectedSymptoms.length; i++) {
      symptoms.add(selectedSymptoms[i]["ID"]);
    }
  }

  bool hasReceivedData = false;

  Future getData() async {
    processSymptoms();
    final String url = "https://sandbox-healthservice.priaid.ch/diagnosis?token=" + token + "&language=en-gb&symptoms=" + symptoms.toString() + "&gender=" + gender + "&year_of_birth=" + year;
    final response = await http.get(Uri.parse(url));
    receivedData = json.decode(response.body);
    print(receivedData);
    setState(() {
      hasReceivedData = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    counter++;
    final route = ModalRoute.of(context);

    var c = MediaQuery.of(context).size.width;

    if (route == null)
      return SizedBox(height: 1);
    else {
      final routeArgs = route.settings.arguments as Map;
      selectedSymptoms = routeArgs["selectedSymptoms"];
      year = routeArgs["year"];
      gender = routeArgs["gender"];

      if (counter == 1) getData();
      print(selectedSymptoms);
      print(year);
      print(gender);
      return Scaffold(
        body: SafeArea(
            child: Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          child: hasReceivedData == false
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    )
                  ],
                )
              : receivedData.length == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Oops! No results found :(",
                                style: TextStyle(
                                  fontFamily: "Product Sans",
                                  fontSize: 20,
                                )),
                          ],
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: const Text(
                            "Results",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.black,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        Container(
                          child: const Text(
                            "Name of the expected disease followed by the prediction accuracy.",
                            style: TextStyle(
                              fontFamily: "Product Sans",
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: ListView.builder(
                                itemCount: receivedData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ResultTiles(receivedData[index]);
                                }),
                          ),
                        ),
                      ],
                    ),
        )),
      );
    }
  }
}
