// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:orderlyflow/palette.dart';
import 'package:orderlyflow/custom_widgets/searchBar.dart';
import 'package:orderlyflow/side_bar.dart';

import 'custom_widgets/BlueBg.dart';

class employeeData extends StatefulWidget {
  const employeeData({super.key});

  @override
  State<employeeData> createState() => employeeDataState();
}

class employeeDataState extends State<employeeData> {
  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(children: [
        const BlueBg(),
        Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SideBar(),
              Column(children: [
                Row(children: [
                  SizedBox(
                    width: ScreenWidth * 0.05,
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            ScreenWidth * 0,
                            ScreenHeight * 0.04,
                            ScreenWidth * 0.05,
                            ScreenHeight * 0.04),
                        width: ScreenWidth * 0.37,
                        height: ScreenHeight * 0.2,
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 46, 64, 83),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 30.0,
                                top: 20.0,
                                right: 30.0,
                                bottom: 20.0),
                            child: Text(
                              "Bonnus /                                                             MONTH",
                              style: TextStyle(
                                  fontSize: ScreenHeight * 0.024,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontFamily: 'neuropol'),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            ScreenWidth * 0,
                            ScreenHeight * 0.04,
                            ScreenWidth * 0.05,
                            ScreenHeight * 0.04),
                        width: ScreenWidth * 0.37,
                        height: ScreenHeight * 0.62,
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                          color: Paletter.mainBgLight,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        /* child: Text(
                          "Personal Data",
                          semanticsLabel: "Personal Data",
                          style: ThemeStyles.containerText,
                        ),*/
                        // ignore: sort_child_properties_last
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(30, 30.0, 30.0, 0),
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: ScreenWidth * 0.15,
                              height: ScreenHeight * 0.15,
                            ),
                          ),
                        ),
                      ),
                    ], //children
                  ),
                  Column(
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(
                              ScreenWidth * 0.04,
                              ScreenHeight * 0.04,
                              ScreenWidth * 0.05,
                              ScreenHeight * 0),
                          width: ScreenWidth * 0.37,
                          height: ScreenHeight * 0.19,
                          alignment: Alignment.topRight,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 217, 136, 128),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 30.0,
                                top: 20.0,
                                right: 30.0,
                                bottom: 20.0),
                            child: Text(
                              "Progress of the                                                          WEEK",
                              style: ThemeStyles.containerText,
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(
                              ScreenWidth * 0.04,
                              ScreenHeight * 0.04,
                              ScreenWidth * 0.05,
                              ScreenHeight * 0),
                          width: ScreenWidth * 0.37,
                          height: ScreenHeight * 0.19,
                          alignment: Alignment.topRight,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 237, 187, 153),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 30.0,
                                top: 20.0,
                                right: 30.0,
                                bottom: 20.0),
                            child: Text(
                              "Salary /                                                             MONTH",
                              style: ThemeStyles.containerText,
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(
                              ScreenWidth * 0.04,
                              ScreenHeight * 0.04,
                              ScreenWidth * 0.05,
                              ScreenHeight * 0),
                          width: ScreenWidth * 0.37,
                          height: ScreenHeight * 0.19,
                          alignment: Alignment.topRight,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 191, 201, 202),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 30.0,
                                top: 20.0,
                                right: 30.0,
                                bottom: 20.0),
                            child: Text(
                              "Hours of work /                                                             WEEK",
                              style: ThemeStyles.containerText,
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(
                              ScreenWidth * 0.04,
                              ScreenHeight * 0.04,
                              ScreenWidth * 0.05,
                              ScreenHeight * 0),
                          width: ScreenWidth * 0.37,
                          height: ScreenHeight * 0.19,
                          alignment: Alignment.topRight,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 81, 90, 90),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          //child: Align(),
                          //alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 30.0,
                                top: 20.0,
                                right: 30.0,
                                bottom: 20.0),
                            child: Text(
                              "Day off /                                                             MONTH",
                              style: ThemeStyles.containerText,
                            ),
                          )),
                    ],
                  ),
                ]),
              ])
            ]),
      ]),
    );
  }
}

class ThemeStyles {
  static const TextStyle containerText = TextStyle(
    fontSize: 24.0,
    decoration: TextDecoration.none,
    fontFamily: 'neuropol',
    color: Color.fromRGBO(20, 70, 103, 1),
  );
}
