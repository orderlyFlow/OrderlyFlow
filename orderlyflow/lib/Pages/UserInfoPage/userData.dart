import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderlyflow/Database/db.dart';

import '../../custom_widgets/BlueBg.dart';
import '../../custom_widgets/palette.dart';
import '../../custom_widgets/side_bar.dart';

class userData extends StatefulWidget {
  const userData({super.key});

  @override
  State<userData> createState() => _userDataState();
}

class _userDataState extends State<userData> {
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
                  final photoData = empInfo['profilePicture'];
                  Uint8List photoBytes = base64Decode(photoData);
                  ImageProvider imageProvider = MemoryImage(photoBytes);
                  return Column(children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(
                            ScreenWidth * 0,
                            ScreenHeight * 0.074,
                            ScreenWidth * 0,
                            ScreenHeight * 0.01),
                        width: ScreenWidth * 0.87,
                        height: ScreenHeight * 0.20,
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 46, 64, 83),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                              ScreenWidth * 0.02,
                              ScreenHeight * 0,
                              ScreenWidth * 0,
                              ScreenHeight * 0.05),
                          child: Text(
                            "Base Salary:\n                            " +
                                salaryInfo['basepay'].toString(),
                            style: TextStyle(
                              fontSize: ScreenHeight * 0.055,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: 'neuropol',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        )),
                    ///////////////////////Employee Info///////////////////////
                    Container(
                        decoration: BoxDecoration(
                          color: Paletter.mainBgLight,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        margin: EdgeInsets.fromLTRB(
                            ScreenWidth * 0.025,
                            ScreenHeight * 0.074,
                            ScreenWidth * 0,
                            ScreenHeight * 0.01),
                        width: ScreenWidth * 0.45,
                        height: ScreenHeight * 0.56,
                        child: Column(children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(
                                  ScreenWidth * 0.015,
                                  ScreenHeight * 0.064,
                                  ScreenWidth * 0,
                                  ScreenHeight * 0.01),
                              width: ScreenWidth * 0.15,
                              height: ScreenHeight * 0.15,
                              child: FittedBox(
                                fit: BoxFit
                                    .contain, // Set the fit property to BoxFit.contain to scale the image proportionally to fit inside the container
                                child: CircleAvatar(
                                  backgroundImage: MemoryImage(photoBytes),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Name :  '
                            '${empInfo['name']}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: 'neuropol',
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            'Phone :  '
                            '${empInfo['phone']}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: 'neuropol',
                            ),
                          ),
                          Text(
                            'Email :  '
                            '${empInfo['email']}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: 'neuropol',
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            'Country :  '
                            '${empInfo['country']}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: 'neuropol',
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            'Position :  '
                            '${empInfo['title']}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: 'neuropol',
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            'Description :  '
                            '${empInfo['jobDescription']}',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: 'neuropol',
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            'ID :  '
                            '${empInfo['ID'].toString()}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: 'neuropol',
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            'Password :  '
                            '${empInfo['password'].toString()}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: 'neuropol',
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            'OTP :  '
                            '${empInfo['OTP'].toString()}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: 'neuropol',
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ]))
                    //,
                  ]);
                }
              }
            })

        ///////////////////////end Future Builder//////////////////////////
      ])
    ]));
  }
}
