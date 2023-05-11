// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:orderlyflow/Database/textControllers.dart';
import 'package:orderlyflow/palette.dart';
import 'package:orderlyflow/custom_widgets/searchBar.dart';
import 'package:orderlyflow/side_bar.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:glass/glass.dart';
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
                        child: FutureBuilder(
                            future: MongoDB.pieChartValues(),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                return PieChart(
                                  dataMap: {
                                    "Office": StoreController.onSiteRatio.value,
                                    "Remote": StoreController.remoteRatio.value,
                                  },
                                  animationDuration: Duration(seconds: 5),
                                  chartLegendSpacing: 29,
                                  chartRadius:
                                      MediaQuery.of(context).size.width / 2,
                                  colorList: colorList,
                                  initialAngleInDegree: 0,
                                  chartType: ChartType.disc,
                                  ringStrokeWidth: 10,
                                  centerText: "Employee",
                                  //  text:"employee",
                                  legendOptions: LegendOptions(
                                    showLegendsInRow: false,
                                    legendPosition: LegendPosition.right,
                                    showLegends: true,
                                    //legendShape: _BoxShape.circle,
                                    legendTextStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'neuropol',
                                      fontSize: 17,
                                    ),
                                  ),
                                  chartValuesOptions: ChartValuesOptions(
                                    showChartValueBackground: false,
                                    showChartValues: true,
                                    showChartValuesInPercentage: false,
                                    showChartValuesOutside: false,
                                    decimalPlaces: 1,
                                  ),
                                );
                              } else {
                                if (!snapshot.hasData ||
                                    ConnectionState ==
                                        ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ));
                                } else {
                                  return Text(
                                      "OOoopppsss.....Error while rendering");
                                }
                              }
                            })),
                    /*asGlass(
                      tintColor: Color.fromARGB(255, 194, 160, 199),
                      clipBorderRadius: BorderRadius.circular(10),
                    ),*/
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
                                  Container(
                                      width: ScreenWidth * 0.36,
                                      height: ScreenHeight * 0.35,
                                      child: FutureBuilder<List<dynamic>>(
                                        future: MongoDB.getIndividualForms1(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            return ListView.builder(
                                              itemCount: snapshot.data!.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                    width: ScreenWidth * 0.34,
                                                    height: ScreenHeight * 0.09,
                                                    child: ListTile(
                                                      onTap: () {},
                                                      title: Text(
                                                          snapshot.data![index]
                                                              ['title']),
                                                      subtitle: Text(snapshot
                                                          .data![index]['Date']
                                                          .toString()),
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
