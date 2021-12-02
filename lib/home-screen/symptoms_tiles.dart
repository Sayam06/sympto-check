import 'package:flutter/material.dart';

class SymptomsTiles extends StatelessWidget {
  Function add;

  final Map data;
  final index;

  SymptomsTiles(this.data, this.add, this.index);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => add(index),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Color.fromRGBO(233, 59, 129, 1)),
          color: Colors.transparent,
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              data["Name"],
              style: TextStyle(
                color: Color.fromRGBO(233, 59, 129, 1),
                fontFamily: "Product Sans",
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
