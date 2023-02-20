import 'package:flutter/material.dart';
import 'package:orderlyflow/palette.dart';
import 'package:orderlyflow/custom_widgets/searchBar.dart';

class employeeData extends StatefulWidget {
  const employeeData({super.key});

  @override
  State<employeeData> createState() => employeeDataState();
}

class employeeDataState extends State<employeeData> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
    // ignore: dead_code
    Home:
    // ignore: non_constant_identifier_names

    Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Container(
                    alignment: Alignment.center,
                    color: Color(0xFF2AA650),
                    child: const Text(
                      "personal data",
                      style: ThemeStyles.containerText,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        color: Color(0XFF58AAE8),
                        child: const Text(
                          "hours of work/week",
                          style: ThemeStyles.containerText,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Container(
                        alignment: Alignment.center,
                        color: Color(0XFFE74E33),
                        child: Text(
                          "hours of work/week",
                          style: ThemeStyles.containerText,
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              color: Color(0xff8D4383),
              child: Text(
                "salary",
                style: ThemeStyles.containerText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ThemeStyles {
  static const TextStyle containerText = TextStyle(
    color: Colors.blueAccent,
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );
}
