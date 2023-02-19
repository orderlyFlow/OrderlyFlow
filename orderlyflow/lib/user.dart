import 'package:flutter/material.dart';

class userData extends StatefulWidget {
  const userData({super.key});

  @override
  State<userData> createState() => _userDataState();
}

class _userDataState extends State<userData> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                    child: Text(
                      "personal data",
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
                        child: Text(
                          "hours of work/week",
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}