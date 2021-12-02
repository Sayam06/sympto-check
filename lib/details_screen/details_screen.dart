import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:symptocheck/token.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = "/details-screen";

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int counter = 0;
  bool hasReceivedData = false;

  String token = TOKEN;

  late String issueID;
  late String name;
  late String specialisation;

  late Map receivedData;

  Future getData() async {
    final String url = "https://sandbox-healthservice.priaid.ch/issues/" + issueID + "/info?token=" + token + "&language=en-gb";
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
      issueID = routeArgs["id"].toString();
      name = routeArgs["name"];
      specialisation = routeArgs["specialisation"];
      if (counter == 1) getData();
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
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              name,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.black,
                                fontSize: 30,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color.fromRGBO(255, 204, 210, 1),
                                    ),
                                    child: Text(
                                      "Possible Symptoms: " + receivedData["PossibleSymptoms"],
                                      style: TextStyle(
                                        fontFamily: "Product Sans",
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color.fromRGBO(246, 234, 190, 1),
                                    ),
                                    child: Text(
                                      "Description: " + receivedData["DescriptionShort"],
                                      style: TextStyle(
                                        fontFamily: "Product Sans",
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color.fromRGBO(147, 181, 198, 1),
                                    ),
                                    child: Text(
                                      "Medical Condition: " + receivedData["MedicalCondition"],
                                      style: TextStyle(
                                        fontFamily: "Product Sans",
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color.fromRGBO(205, 242, 202, 1),
                                    ),
                                    child: Text(
                                      "Treatment: " + receivedData["TreatmentDescription"],
                                      style: TextStyle(
                                        fontFamily: "Product Sans",
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Text(
                                      "Streams: " + specialisation,
                                      style: TextStyle(
                                        fontFamily: "Product Sans",
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Text(
                                      "Scientific Name " + receivedData["ProfName"],
                                      style: TextStyle(
                                        fontFamily: "Product Sans",
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ))),
      );
    }
  }
}
