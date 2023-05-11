import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderlyflow/palette.dart';
import 'package:orderlyflow/custom_widgets/searchBar.dart';
import 'package:orderlyflow/side_bar.dart';
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
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(Icons.edit),
                      ],
                    ),
                    FutureBuilder(
                      future: MongoDB.getInfobyid(100001),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          final employee = snapshot.data;
                          return Column(children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  ScreenWidth * 0.02,
                                  ScreenHeight * 0.04,
                                  ScreenWidth * 0,
                                  ScreenHeight * 0),
                              width: ScreenWidth * 0.05,
                              height: ScreenHeight * 0.10,
                              child: CircleAvatar(
                                backgroundImage: MemoryImage(base64Decode(
                                    snapshot.data['profilePicture'])),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  ScreenWidth * 0.0,
                                  ScreenHeight * 0.0,
                                  ScreenWidth * 0,
                                  ScreenHeight * 0),
                              width: ScreenWidth * 0.75,
                              height: ScreenHeight * 0.05,
                              decoration: BoxDecoration(
                                // color: const Color.fromARGB(205, 92, 92, 92),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                snapshot.data!['name'],
                                style: ThemeStyles.containerText,
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(
                                    ScreenWidth * 0.0,
                                    ScreenHeight * 0.0,
                                    ScreenWidth * 0,
                                    ScreenHeight * 0),
                                width: ScreenWidth * 0.75,
                                height: ScreenHeight * 0.05,
                                decoration: BoxDecoration(
                                  // color: const Color.fromARGB(205, 92, 92, 92),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  snapshot.data!['ID'].toString(),
                                  style: ThemeStyles.containerText,
                                )),
                            Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  ScreenWidth * 0.0,
                                  ScreenHeight * 0.0,
                                  ScreenWidth * 0,
                                  ScreenHeight * 0),
                              width: ScreenWidth * 0.75,
                              height: ScreenHeight * 0.05,
                              decoration: BoxDecoration(
                                //color: const Color.fromARGB(205, 92, 92, 92),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                snapshot.data!['OTP'].toString(),
                                style: ThemeStyles.containerText,
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  ScreenWidth * 0.0,
                                  ScreenHeight * 0.0,
                                  ScreenWidth * 0,
                                  ScreenHeight * 0),
                              width: ScreenWidth * 0.75,
                              height: ScreenHeight * 0.05,
                              decoration: BoxDecoration(
                                //  color: const Color.fromARGB(205, 92, 92, 92),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                snapshot.data!['phone'].toString(),
                                style: ThemeStyles.containerText,
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  ScreenWidth * 0.0,
                                  ScreenHeight * 0.0,
                                  ScreenWidth * 0,
                                  ScreenHeight * 0),
                              width: ScreenWidth * 0.75,
                              height: ScreenHeight * 0.05,
                              decoration: BoxDecoration(
                                //color: const Color.fromARGB(205, 92, 92, 92),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                snapshot.data!['email'],
                                style: ThemeStyles.containerText,
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  ScreenWidth * 0.0,
                                  ScreenHeight * 0.0,
                                  ScreenWidth * 0,
                                  ScreenHeight * 0),
                              width: ScreenWidth * 0.75,
                              height: ScreenHeight * 0.05,
                              decoration: BoxDecoration(
                                //color: const Color.fromARGB(205, 92, 92, 92),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                snapshot.data!['password'].toString(),
                                style: ThemeStyles.containerText,
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  ScreenWidth * 0.0,
                                  ScreenHeight * 0.0,
                                  ScreenWidth * 0,
                                  ScreenHeight * 0),
                              width: ScreenWidth * 0.75,
                              height: ScreenHeight * 0.05,
                              decoration: BoxDecoration(
                                //color: const Color.fromARGB(205, 92, 92, 92),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                snapshot.data!['title'],
                                style: ThemeStyles.containerText,
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  ScreenWidth * 0.0,
                                  ScreenHeight * 0.0,
                                  ScreenWidth * 0,
                                  ScreenHeight * 0),
                              width: ScreenWidth * 0.75,
                              height: ScreenHeight * 0.05,
                              decoration: BoxDecoration(
                                //color: const Color.fromARGB(205, 92, 92, 92),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                snapshot.data!['status'],
                                style: ThemeStyles.containerText,
                              ),
                            ),
                          ]);
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    )
                  ])),
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
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 30.0, top: 20.0, right: 30.0, bottom: 20.0),
                    child: const Text(
                      "FORMS",
                      style: ThemeStyles.containerText,
                    ),
                  ),
                  Container(
                      width: ScreenWidth * 0.36,
                      height: ScreenHeight * 0.45,
                      child: FutureBuilder<List<dynamic>>(
                        future: MongoDB.getIndividualForms(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    width: ScreenWidth * 0.34,
                                    height: ScreenHeight * 0.13,
                                    child: ListTile(
                                      onTap: () {},
                                      title:
                                          Text(snapshot.data![index]['title']),
                                      subtitle: Text(snapshot.data![index]
                                              ['Date']
                                          .toString()),
                                    ));
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Container(
                                width: ScreenWidth * 0.16,
                                height: ScreenHeight * 0.24,
                                child:
                                    Center(child: CircularProgressIndicator()));
                          }
                        },
                      )),
                ])),
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
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 30.0, top: 20.0, right: 30.0, bottom: 20.0),
                    child: const Text(
                      "PAYROLL",
                      style: ThemeStyles.containerText,
                    ),
                  ),
                  Container(
                      width: ScreenWidth * 0.36,
                      height: ScreenHeight * 0.15,
                      child: FutureBuilder<dynamic>(
                        future: MongoDB.getSalaryhr(100001),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      "SALARY: ${snapshot.data!['basepay'].toString()}",
                                      style: ThemeStyles.containerText,
                                    ),
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        //color: const Color.fromARGB(205, 92, 92, 92),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "HoursOfWork: ${snapshot.data!['hoursOW'].toString()}",
                                        style: ThemeStyles.containerText,
                                      )),
                                  Container(
                                      decoration: BoxDecoration(
                                        //color: const Color.fromARGB(205, 92, 92, 92),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "Bonus: ${snapshot.data!['bonus'].toString()}",
                                        style: ThemeStyles.containerText,
                                      )),
                                  Container(
                                      decoration: BoxDecoration(
                                        // color: const Color.fromARGB(205, 92, 92, 92),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "Daysoff: ${snapshot.data!['daysOff'].toString()}",
                                        style: ThemeStyles.containerText,
                                      ))
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Container(
                                width: ScreenWidth * 0.16,
                                height: ScreenHeight * 0.24,
                                child:
                                    Center(child: CircularProgressIndicator()));
                          }
                        },
                      )),
                ])),
          ],
        ),
      ])
    ]));
  }
}

class ThemeStyles {
  static const TextStyle containerText = TextStyle(
    fontSize: 25.0,
    decoration: TextDecoration.none,
    fontFamily: 'neuropol',
    color: Color.fromRGBO(20, 70, 103, 1),
  );
}
