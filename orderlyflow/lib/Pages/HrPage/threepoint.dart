import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:orderlyflow/custom_widgets/searchBar.dart';
import 'package:orderlyflow/custom_widgets/side_bar.dart';
import '../../Database/db.dart';
import '../../custom_widgets/BlueBg.dart';
import 'package:orderlyflow/Database/db.dart';

class threepoint extends StatefulWidget {
  const threepoint({super.key});

  @override
  threepointState createState() => threepointState();
}

class threepointState extends State<threepoint> {
  Future? _future;
  Future<dynamic> sendData() async {
    final data1 = await MongoDB.getSalary();
    final data2 = await MongoDB.getInfo();
    return [data1, data2];
  }

  void initState() {
    _future = sendData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(children: [
      const BlueBg(),
      Row(children: [
        const SideBar(),
        Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(ScreenWidth * 0.02,
                  ScreenHeight * 0.04, ScreenWidth * 0, ScreenHeight * 0),
              width: ScreenWidth * 0.48,
              height: ScreenHeight * 0.92,
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 46, 64, 83),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                  margin: const EdgeInsets.only(
                      left: 30.0, top: 20, right: 30.0, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(Icons.edit),
                    ],
                  )),
            ),
          ],
        ),

        ///////////////////////////end of employee container//////////////////////////
        Column(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(ScreenWidth * 0.05,
                    ScreenHeight * 0.04, ScreenWidth * 0.02, ScreenHeight * 0),
                width: ScreenWidth * 0.36,
                height: ScreenHeight * 0.59,
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 191, 201, 202),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 30.0, top: 20.0, right: 30.0, bottom: 20.0),
                  child: const Text(
                    "REPORTS",
                    style: ThemeStyles.containerText,
                  ),
                )),
            Container(
                margin: EdgeInsets.fromLTRB(ScreenWidth * 0.05,
                    ScreenHeight * 0.04, ScreenWidth * 0.02, ScreenHeight * 0),
                width: ScreenWidth * 0.36,
                height: ScreenHeight * 0.29,
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 81, 90, 90),
                  borderRadius: BorderRadius.circular(30),
                ),
                //child: Align(),
                //alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 30.0, top: 30.0, right: 30.0, bottom: 0),
                  child: const Text(
                    "SALARY",
                    style: ThemeStyles.containerText,
                  ),
                )),
          ],
        ),
      ])
    ]));
  }
}

class ThemeStyles {
  static const TextStyle containerText = TextStyle(
    fontSize: 28.0,
    decoration: TextDecoration.none,
    fontFamily: 'neuropol',
    color: Color.fromRGBO(20, 70, 103, 1),
  );
}
