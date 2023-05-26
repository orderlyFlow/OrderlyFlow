// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orderlyflow/Database/textControllers.dart';
import 'package:orderlyflow/Pages/hrpage/threepoint.dart';
import 'package:orderlyflow/custom_widgets/searchBar.dart';
import 'package:glass/glass.dart';
import 'package:orderlyflow/custom_widgets/side_bar.dart';
import '../../Database/db.dart';
import '../../custom_widgets/BlueBg.dart';

class HRpage extends StatefulWidget {
  const HRpage({super.key});

  @override
  HRpageState createState() => HRpageState();
}

class HRpageState extends State<HRpage> {
  Uint8List? get PhotoBytes => null;

  List<Color> colorList = [
    Color.fromARGB(255, 122, 92, 128),
    Color.fromARGB(255, 118, 155, 138),
  ];
  bool ischecked = false;

  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    Map<String, double> dataMap;

    return Scaffold(
        body: Stack(children: [
      const BlueBg(),
      Row(children: [
        SideBar(),
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        Row(children: [
          Container(
              margin: EdgeInsets.fromLTRB(ScreenWidth * 0.01,
                  ScreenHeight * 0.01, ScreenWidth * 0.01, ScreenHeight * 0.01),
              width: ScreenWidth * 0.91,
              height: ScreenHeight * 0.98,
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 206, 202, 207),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        ScreenWidth * 0.02,
                        ScreenHeight * 0.02,
                        ScreenWidth * 0.02,
                        ScreenHeight * 0.02),
                    width: ScreenWidth * 0.9,
                    height: ScreenHeight * 0.45,
                    //alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 46, 64, 83),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(
                          ScreenWidth * 0.03,
                          ScreenHeight * 0.03,
                          ScreenWidth * 0,
                          ScreenHeight * 0),
                      child: Column(mainAxisSize: MainAxisSize.max, children: [
                        Text(
                          "Recruitment Progress",
                          style: TextStyle(
                            fontSize: ScreenHeight * 0.05,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontFamily: 'neuropol',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                            width: ScreenWidth * 0.8,
                            height: ScreenHeight * 0.35,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 236, 228, 238),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: SingleChildScrollView(
                                child: FutureBuilder(
                                    future: MongoDB.fetchAll(),
                                    builder:
                                        (buildContext, AsyncSnapshot snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      } else if (snapshot.hasData) {
                                        return ListView.builder(
                                          itemCount: snapshot.data!.length,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) =>
                                              ListTile(
                                            leading: CircleAvatar(
                                              backgroundImage: MemoryImage(
                                                  base64Decode(StoreController
                                                          .allUsers[index]
                                                      ['profilePicture'])),
                                            ),
                                            title: Text(
                                              StoreController.allUsers[index]
                                                  ['name'],
                                              style: ThemeStyles1.containerText,
                                            ),
                                            trailing: Wrap(
                                              spacing: ScreenWidth * 0.079,
                                              children: <Widget>[
                                                Text(
                                                  StoreController
                                                      .allUsers[index]['email'],
                                                  style: ThemeStyles1
                                                      .containerText,
                                                ),
                                                Text(
                                                  StoreController
                                                      .allUsers[index]['phone'],
                                                  style: ThemeStyles1
                                                      .containerText,
                                                ),
                                                Text(
                                                  StoreController
                                                      .allUsers[index]['title'],
                                                  style: ThemeStyles1
                                                      .containerText,
                                                ),
                                                Container(
                                                  child: TextButton(
                                                    onPressed: () {
                                                      StoreController
                                                              .selectedUser =
                                                          StoreController
                                                              .allUsers[index];
                                                      print(StoreController
                                                          .selectedUser!['ID']
                                                          .toString());
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  threepoint()));
                                                    },
                                                    child: Text("more"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.blueGrey
                                                .withOpacity(0.5),
                                          ),
                                        );
                                      }
                                    }))),
                      ]),
                    ),
                  ),
                  Row(children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          ScreenWidth * 0.04,
                          ScreenHeight * 0.02,
                          ScreenWidth * 0.02,
                          ScreenHeight * 0),
                      width: ScreenWidth * 0.42,
                      height: ScreenHeight * 0.46,
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                        //color: Color.fromARGB(255, 115, 114, 170),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(
                        "assets/images/HR.gif",
                        width: ScreenWidth * 0.50,
                        height: ScreenHeight * 0.46,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(
                            ScreenWidth * 0.02,
                            ScreenHeight * 0,
                            ScreenWidth * 0.01,
                            ScreenHeight * 0),
                        width: ScreenWidth * 0.38,
                        height: ScreenHeight * 0.46,
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 73, 86, 95),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                            margin: EdgeInsets.fromLTRB(
                                ScreenWidth * 0.03,
                                ScreenHeight * 0.03,
                                ScreenWidth * 0,
                                ScreenHeight * 0),
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Reports",
                                    style: TextStyle(
                                      fontSize: ScreenHeight * 0.04,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontFamily: 'neuropol',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Container(
                                      width: ScreenWidth * 0.36,
                                      height: ScreenHeight * 0.35,
                                      child: FutureBuilder<List<dynamic>>(
                                        future: MongoDB.getIndividualForms(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            return ListView.builder(
                                              itemCount: snapshot.data!.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                DateTime dateUTC = snapshot
                                                    .data![index]['Date'];
                                                Duration offset = DateTime.now()
                                                    .timeZoneOffset;
                                                DateTime localTime =
                                                    dateUTC.add(offset);
                                                String localReqTime =
                                                    DateFormat('HH:mm:a')
                                                        .format(localTime);
                                                String date = dateUTC.weekday
                                                        .toString() +
                                                    dateUTC.month.toString() +
                                                    dateUTC.year.toString();
                                                return Container(
                                                    width: ScreenWidth * 0.34,
                                                    height: ScreenHeight * 0.09,
                                                    child: ListTile(
                                                      onTap: () {},
                                                      title: Text(
                                                        snapshot.data![index]
                                                            ['title'],
                                                        style: ThemeStyles
                                                            .containerText,
                                                      ),
                                                      subtitle: Text(
                                                        localReqTime + date,
                                                        style: ThemeStyles
                                                            .containerText,
                                                      ),
                                                    ));
                                              },
                                            );
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else {
                                            return Container(
                                                width: ScreenWidth * 0.16,
                                                height: ScreenHeight * 0.10,
                                                child: Center(
                                                    child:
                                                        CircularProgressIndicator()));
                                          }
                                        },
                                      )),
                                ]))),
                  ]),
                ],
              ))
        ])
      ]),
    ]));
  }
}

class ThemeStyles {
  static const TextStyle containerText = TextStyle(
    fontSize: 18.0,
    decoration: TextDecoration.none,
    fontFamily: 'neuropol',
    color: Color.fromRGBO(20, 70, 103, 1),
  );
}

class ThemeStyles1 {
  static const TextStyle containerText = TextStyle(
    fontSize: 15.0,
    decoration: TextDecoration.none,
    fontFamily: 'neuropol',
    color: Color.fromRGBO(20, 70, 103, 1),
  );
}
