// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';
import 'package:orderlyflow/custom_widgets/searchBar.dart';
import 'package:orderlyflow/custom_widgets/side_bar.dart';

import '../../Database/db.dart';
import '../../custom_widgets/BlueBg.dart';

class employeeData extends StatefulWidget {
  const employeeData({super.key});

  @override
  State<employeeData> createState() => employeeDataState();
}

class employeeDataState extends State<employeeData> {
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(children: [
        const BlueBg(),
        Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SideBar(),
              FutureBuilder(
                  future: _future,
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      ));
                    } else {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else {
                        final salaryInfo = snapshot.data[0];
                        final empInfo = snapshot.data[1];
                        int bonus = int.parse(
                            ((salaryInfo['bonus'] * salaryInfo['basepay']) /
                                    100) +
                                salaryInfo['basepay']);
                        final photoData = empInfo['profilePicture'];
                        Uint8List photoBytes = base64Decode(photoData);
                        ImageProvider imageProvider = MemoryImage(photoBytes);
                        return Column(
                          children: [
                            Container(
                                margin: EdgeInsets.fromLTRB(
                                    screenWidth * 0.027,
                                    screenHeight * 0.045,
                                    screenWidth * 0,
                                    screenHeight * 0.02),
                                width: screenWidth * 0.87,
                                height: screenHeight * 0.20,
                                alignment: Alignment.bottomLeft,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 84, 90, 121),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      screenWidth * 0.02,
                                      screenHeight * 0,
                                      screenWidth * 0,
                                      screenHeight * 0.05),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Yearly Bonus:       $bonus",
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.035,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontFamily: 'neuropol',
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                )),
                            ///////////////////////Employee Info///////////////////////
                            Row(children: [
                              Container(
                                  decoration: BoxDecoration(
                                    color: Paletter.mainBgLight,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  margin: EdgeInsets.fromLTRB(
                                      screenWidth * 0.03,
                                      screenHeight * 0.035,
                                      screenWidth * 0,
                                      screenHeight * 0.02),
                                  width: screenWidth * 0.4,
                                  height: screenHeight * 0.65,
                                  child: Column(children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          screenWidth * 0.018,
                                          screenHeight * 0.05,
                                          screenWidth * 0,
                                          screenHeight * 0.01),
                                      width: screenWidth * 0.12,
                                      height: screenHeight * 0.15,
                                      child: FittedBox(
                                        fit: BoxFit
                                            .contain, // Set the fit property to BoxFit.contain to scale the image proportionally to fit inside the container
                                        child: CircleAvatar(
                                          backgroundImage:
                                              MemoryImage(photoBytes),
                                        ),
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                screenWidth * 0,
                                                screenHeight * 0.01,
                                                screenWidth * 0,
                                                screenHeight * 0.01),
                                            padding: EdgeInsets.fromLTRB(
                                                screenWidth * 0.02,
                                                screenHeight * 0,
                                                screenWidth * 0,
                                                screenHeight * 0.01),
                                            child: Text(
                                              'Name :  '
                                              '${empInfo['name']}',
                                              style: TextStyle(
                                                fontSize: screenHeight * 0.025,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontFamily: 'neuropol',
                                              ),
                                              textAlign: TextAlign.justify,
                                            ))),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                screenWidth * 0,
                                                screenHeight * 0.005,
                                                screenWidth * 0,
                                                screenHeight * 0.01),
                                            padding: EdgeInsets.fromLTRB(
                                                screenWidth * 0.02,
                                                screenHeight * 0,
                                                screenWidth * 0,
                                                screenHeight * 0.01),
                                            child: Text(
                                              'Phone :  '
                                              '${empInfo['phone']}',
                                              style: TextStyle(
                                                fontSize: screenHeight * 0.025,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontFamily: 'neuropol',
                                              ),
                                            ))),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                screenWidth * 0,
                                                screenHeight * 0.005,
                                                screenWidth * 0,
                                                screenHeight * 0.01),
                                            padding: EdgeInsets.fromLTRB(
                                                screenWidth * 0.02,
                                                screenHeight * 0,
                                                screenWidth * 0,
                                                screenHeight * 0.01),
                                            child: Text(
                                              'Email :  '
                                              '${empInfo['email']}',
                                              style: TextStyle(
                                                fontSize: screenHeight * 0.025,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontFamily: 'neuropol',
                                              ),
                                              textAlign: TextAlign.justify,
                                            ))),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                screenWidth * 0,
                                                screenHeight * 0.005,
                                                screenWidth * 0,
                                                screenHeight * 0.01),
                                            padding: EdgeInsets.fromLTRB(
                                                screenWidth * 0.02,
                                                screenHeight * 0,
                                                screenWidth * 0,
                                                screenHeight * 0.01),
                                            child: Text(
                                              'Country :  '
                                              '${empInfo['country']}',
                                              style: TextStyle(
                                                fontSize: screenHeight * 0.025,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontFamily: 'neuropol',
                                              ),
                                              textAlign: TextAlign.justify,
                                            ))),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                screenWidth * 0,
                                                screenHeight * 0.005,
                                                screenWidth * 0,
                                                screenHeight * 0.01),
                                            padding: EdgeInsets.fromLTRB(
                                                screenWidth * 0.02,
                                                screenHeight * 0,
                                                screenWidth * 0,
                                                screenHeight * 0.01),
                                            child: Text(
                                              'Position :  '
                                              '${empInfo['title']}',
                                              style: TextStyle(
                                                fontSize: screenHeight * 0.025,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontFamily: 'neuropol',
                                              ),
                                              textAlign: TextAlign.justify,
                                            ))),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                screenWidth * 0,
                                                screenHeight * 0.005,
                                                screenWidth * 0,
                                                screenHeight * 0.01),
                                            padding: EdgeInsets.fromLTRB(
                                                screenWidth * 0.02,
                                                screenHeight * 0,
                                                screenWidth * 0,
                                                screenHeight * 0.01),
                                            width: screenWidth * 0.34,
                                            child: Text(
                                              'Description :  '
                                              '${empInfo['jobDescription']}',
                                              style: TextStyle(
                                                fontSize: screenHeight * 0.025,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontFamily: 'neuropol',
                                              ),
                                              textAlign: TextAlign.left,
                                            ))),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                screenWidth * 0,
                                                screenHeight * 0.005,
                                                screenWidth * 0,
                                                screenHeight * 0.01),
                                            padding: EdgeInsets.fromLTRB(
                                                screenWidth * 0.02,
                                                screenHeight * 0,
                                                screenWidth * 0,
                                                screenHeight * 0.01),
                                            child: Text(
                                              'ID :  '
                                              '${empInfo['ID'].toString()}',
                                              style: TextStyle(
                                                fontSize: screenHeight * 0.025,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontFamily: 'neuropol',
                                              ),
                                              textAlign: TextAlign.justify,
                                            ))),
                                  ])),
                              Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.fromLTRB(
                                          screenWidth * 0.034,
                                          screenHeight * 0.0112,
                                          screenWidth * 0,
                                          screenHeight * 0),
                                      width: screenWidth * 0.44,
                                      height: screenHeight * 0.19,
                                      alignment: Alignment.topRight,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 237, 187, 153),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(
                                            screenWidth * 0.02,
                                            screenHeight * 0.0,
                                            screenWidth * 0,
                                            screenHeight * 0.03),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Base Pay:       " +
                                                salaryInfo['basepay']
                                                    .toString(),
                                            style: TextStyle(
                                              fontSize: screenHeight * 0.035,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontFamily: 'neuropol',
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                    height: screenHeight * 0.033,
                                  ),
                                  Container(
                                      margin: EdgeInsets.fromLTRB(
                                          screenWidth * 0.032,
                                          screenHeight * 0,
                                          screenWidth * 0,
                                          screenHeight * 0),
                                      width: screenWidth * 0.44,
                                      height: screenHeight * 0.19,
                                      alignment: Alignment.topRight,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 191, 201, 202),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 30.0,
                                            top: 20.0,
                                            right: 30.0,
                                            bottom: 20.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Hours of Work:       " +
                                                salaryInfo['hoursOW']
                                                    .toString(),
                                            style: TextStyle(
                                              fontSize: screenHeight * 0.035,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontFamily: 'neuropol',
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                    height: screenHeight * 0.031,
                                  ),
                                  Container(
                                      margin: EdgeInsets.fromLTRB(
                                          screenWidth * 0.032,
                                          screenHeight * 0,
                                          screenWidth * 0,
                                          screenHeight * 0),
                                      width: screenWidth * 0.44,
                                      height: screenHeight * 0.19,
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.fromLTRB(
                                          screenWidth * 0.03,
                                          screenHeight * 0,
                                          screenWidth * 0,
                                          screenHeight * 0.01),
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 86, 96, 96),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Days Off left:       " +
                                              salaryInfo['daysOff'].toString(),
                                          style: TextStyle(
                                            fontSize: screenHeight * 0.035,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontFamily: 'neuropol',
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      )),
                                ],
                              ),
                              //,
                            ])
                          ],
                        );
                      }
                    }
                  })
              /* 
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
              ])*/
            ]),
      ]),
    );
  }
}
