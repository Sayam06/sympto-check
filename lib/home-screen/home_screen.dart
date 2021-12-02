import 'package:flutter/material.dart';
import 'package:symptocheck/home-screen/symptoms_tiles.dart';
import 'package:symptocheck/results/results_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "home-screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List data;

  List selectedSymptoms = [];

  String gender = "";
  String errorText = "";

  TextEditingController yearContoller = new TextEditingController();

  void add(int index) {
    if (!selectedSymptoms.contains(data[index])) {
      selectedSymptoms.add(data[index]);
      print("Element added!");
      setState(() {});
    }
  }

  void delete(int index) {
    selectedSymptoms.remove(selectedSymptoms[index]);
    setState(() {});
    print("Element deleted!");
  }

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);

    var c = MediaQuery.of(context).size.width;

    if (route == null)
      return SizedBox(height: 1);
    else {
      final routeArgs = route.settings.arguments as Map;
      data = routeArgs["data"];

      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: const Text(
                    "Symptoms",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: const Text(
                    "Added Symptoms",
                    style: TextStyle(
                      fontFamily: "Product Sans",
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                Container(
                  child: const Text(
                    "Tap on a symptom to delete it",
                    style: TextStyle(
                      fontFamily: "Product Sans",
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 204, 210, 1),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  height: 260,
                  width: 500,
                  child: Row(
                    children: [
                      Container(
                        width: 330,
                        height: 500,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                          child: GridView.builder(
                              itemBuilder: (BuildContext ctx, index) {
                                return SymptomsTiles(selectedSymptoms[index], delete, index);
                              },
                              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 0.5 * c,
                                childAspectRatio: 5.5 / 2.5,
                                crossAxisSpacing: 0.05 * c,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: selectedSymptoms.length),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
                          color: Color.fromRGBO(147, 181, 198, 1),
                        ),
                        child: Center(
                          child: GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(360)),
                                color: Colors.white,
                              ),
                              child: Text(
                                "Go",
                                style: TextStyle(fontSize: 18, fontFamily: "Product Sans"),
                              ),
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState) {
                                        return Padding(
                                            padding: EdgeInsets.all(15),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Select your gender",
                                                  style: TextStyle(
                                                    fontFamily: "Product Sans",
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: Color.fromRGBO(233, 59, 129, 1),
                                                          ),
                                                          borderRadius: BorderRadius.all(Radius.circular(30))),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(30),
                                                        child: Container(
                                                          // decoration: BoxDecoration(
                                                          //     border: Border.all(
                                                          //       color: Color.fromRGBO(233, 59, 129, 1),
                                                          //     ),
                                                          //     borderRadius: BorderRadius.all(Radius.circular(15))),
                                                          child: Row(
                                                            children: [
                                                              GestureDetector(
                                                                child: ClipRRect(
                                                                  borderRadius: BorderRadius.circular(gender == "male" ? 30 : 0),
                                                                  child: Container(
                                                                    child: Center(
                                                                        child: Text(
                                                                      "Male",
                                                                      style: TextStyle(fontFamily: "Product Sans", fontSize: 18, color: gender == "male" ? Colors.white : Color.fromRGBO(233, 59, 129, 1)),
                                                                    )),
                                                                    height: 40,
                                                                    width: gender == "male" ? 150 : 130,
                                                                    color: gender == "male" ? Color.fromRGBO(233, 59, 129, 1) : Colors.white,
                                                                  ),
                                                                ),
                                                                onTap: () {
                                                                  setState(() {
                                                                    gender = "male";
                                                                  });
                                                                },
                                                              ),
                                                              GestureDetector(
                                                                child: ClipRRect(
                                                                  borderRadius: BorderRadius.circular(gender == "female" ? 30 : 0),
                                                                  child: Container(
                                                                    child: Center(
                                                                        child: Text(
                                                                      "Female",
                                                                      style: TextStyle(
                                                                        fontFamily: "Product Sans",
                                                                        fontSize: 18,
                                                                        color: gender == "female" ? Colors.white : Color.fromRGBO(233, 59, 129, 1),
                                                                      ),
                                                                    )),
                                                                    height: 40,
                                                                    width: gender == "female" ? 150 : 130,
                                                                    color: gender == "female" ? Color.fromRGBO(233, 59, 129, 1) : Colors.white,
                                                                  ),
                                                                ),
                                                                onTap: () {
                                                                  setState(() {
                                                                    gender = "female";
                                                                  });
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Enter your year of birth: ",
                                                  style: TextStyle(
                                                    fontFamily: "Product Sans",
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 100,
                                                      child: TextField(
                                                        decoration: InputDecoration(
                                                          counter: Offstage(),
                                                        ),
                                                        controller: yearContoller,
                                                        keyboardType: TextInputType.number,
                                                        maxLength: 4,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily: "Product Sans",
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      ElevatedButton(
                                                        style: ButtonStyle(
                                                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(20, 39, 155, 1)),
                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(30.0),
                                                            ),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          if (gender == "" || yearContoller.text.isEmpty) {
                                                            setState(() {
                                                              errorText = "Please enter all the details!";
                                                            });
                                                            return;
                                                          }
                                                          setState(() {
                                                            errorText = "";
                                                          });
                                                          Navigator.of(context).pushNamed(ResultsScreen.routeName, arguments: {"selectedSymptoms": selectedSymptoms, "gender": gender, "year": yearContoller.text});
                                                        },
                                                        child: Container(
                                                          width: 100,
                                                          height: 50,
                                                          child: Center(
                                                            child: Text(
                                                              "Search",
                                                              style: TextStyle(
                                                                fontFamily: "Product Sans",
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      errorText,
                                                      style: TextStyle(
                                                        fontFamily: "Product Sans",
                                                        fontSize: 14,
                                                        color: Colors.red,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ));
                                      },
                                    );
                                  });
                            },
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: const Text(
                    "Tap to select your symptoms:",
                    style: TextStyle(
                      fontFamily: "Product Sans",
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(205, 242, 202, 1),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    height: 280,
                    width: 500,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                      child: GridView.builder(
                          itemBuilder: (BuildContext ctx, index) {
                            return SymptomsTiles(data[index], add, index);
                          },
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 0.5 * c,
                            childAspectRatio: 5.5 / 2.5,
                            crossAxisSpacing: 0.05 * c,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: data.length),
                    )),
              ],
            ),
          ),
        ),
      );
    }
  }
}
