import 'package:flutter/material.dart';
import 'package:symptocheck/details_screen/details_screen.dart';

class ResultTiles extends StatelessWidget {
  Map issues;
  ResultTiles(this.issues);

  String percentage = "";
  String specialisation = "";

  void getSpecialisation() {
    int i = 0;
    for (i; i < issues["Specialisation"].length - 1; i++) {
      specialisation += issues["Specialisation"][i]["Name"] + ", ";
    }
    specialisation += issues["Specialisation"][i]["Name"];
  }

  void trimString() {
    String originalPercentage = issues["Issue"]["Accuracy"].toString();
    for (int i = 0; i < originalPercentage.length; i++) {
      if (originalPercentage[i] != ".") {
        percentage += originalPercentage[i];
      } else {
        print(percentage);
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    trimString();
    getSpecialisation();
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
          color: Color.fromRGBO(254, 245, 237, 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: 300,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          issues["Issue"]["Name"],
                          style: TextStyle(
                            fontFamily: "Product Sans",
                            fontSize: 25,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: Color.fromRGBO(52, 190, 130, 1),
                ),
                child: Center(
                  child: Text(
                    percentage + "%",
                    style: TextStyle(
                      fontFamily: "Product Sans",
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(DetailsScreen.routeName, arguments: {
          "id": issues["Issue"]["ID"],
          "name": issues["Issue"]["Name"],
          "specialisation": specialisation,
        });
      },
    );
  }
}
