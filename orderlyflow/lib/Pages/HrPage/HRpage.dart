// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:orderlyflow/Database/textControllers.dart';
import 'package:orderlyflow/custom_widgets/searchBar.dart';
import 'package:orderlyflow/custom_widgets/side_bar.dart';
import 'package:glass/glass.dart';
import '../../Database/db.dart';
import '../../custom_widgets/BlueBg.dart';

class HrPage extends StatefulWidget {
  const HrPage({super.key});

  @override
  HrPageState createState() => HrPageState();
}

class HrPageState extends State<HrPage> {
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
    //MongoDB.pieChartValues();
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
                        /* FlatButton(
                          onPressed: () {
                            // Action to perform when button is pressed
                          },
                          child: Text('New employee'),
                          color: Colors.teal,
                          textColor: Colors.white,
                        ),*/
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
                                                  base64Decode(
                                                      snapshot.data![index]
                                                          ['profilePicture'])),
                                            ),
                                            title: Text(
                                                snapshot.data![index]['name']),
                                            trailing: Wrap(
                                              spacing: ScreenWidth * 0.079,
                                              children: <Widget>[
                                                Text(snapshot.data![index]
                                                    ['email']),
                                                Text(snapshot.data![index]
                                                    ['phone']),
                                                Text(snapshot.data![index]
                                                    ['title']),
                                                Icon(Icons.more_horiz),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Text("rendering");
                                      }
                                    }))),
                      ]),
                    ),
                  ),
                  Row(children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          ScreenWidth * 0.02,
                          ScreenHeight * 0,
                          ScreenWidth * 0.01,
                          ScreenHeight * 0),
                      width: ScreenWidth * 0.42,
                      height: ScreenHeight * 0.46,
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                        //color: Color.fromARGB(255, 115, 114, 170),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      ////////////////////////child://///////////////
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(
                            ScreenWidth * 0.02,
                            ScreenHeight * 0,
                            ScreenWidth * 0.02,
                            ScreenHeight * 0),
                        width: ScreenWidth * 0.42,
                        height: ScreenHeight * 0.46,
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 93, 86, 95),
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
                                ]))
                        /*child: Container(
                          margin: EdgeInsets.only(
                              left: 30.0, top: 80.0, right: 30.0, bottom: 90.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Checkbox(
                                  value: ischecked,
                                  onChanged: (bool? newValue) {
                                    ischecked = newValue!;
                                  })
                            ],
                          ),
                        )*/
                        ),
                  ]),
                ],
              ))
        ])
      ]),
    ]));
  }
}

FlatButton({
  required Null Function() onPressed,
  required Text child,
  required MaterialColor color,
  required Color textColor,
}) {}
