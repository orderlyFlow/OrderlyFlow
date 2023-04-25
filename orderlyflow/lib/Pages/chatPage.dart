// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';

import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import 'package:orderlyflow/Database/constant.dart';
import 'package:orderlyflow/Database/db.dart';
import 'package:orderlyflow/Database/textControllers.dart';
import 'package:orderlyflow/palette.dart';
import 'package:orderlyflow/custom_widgets/searchBar.dart';

import '../Database/db.dart';
import '../Database/sendMail.dart';
import '../custom_widgets/BlueBg.dart';
import '../side_bar.dart';

class chatPage extends StatefulWidget {
  const chatPage({super.key});

  @override
  State<chatPage> createState() => chatPageState();
}

class chatPageState extends State<chatPage> {
  bool isHovered = false;
  bool isVisible = false;
  final myController = TextEditingController();
  @override
  static void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  void onEntered(bool isHovered) => setState(() {
        this.isHovered = isHovered;
      });
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(children: [
      const BlueBg(),
      Row(children: [
        SideBar(),
        Container(
          margin: EdgeInsets.fromLTRB(
              0.03 * ScreenWidth, 0.02 * ScreenHeight, 0.02 * ScreenWidth, 0),
          height: ScreenHeight * 0.92,
          width: ScreenWidth * 0.88,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Paletter.mainBgLight,
          ),
          child: Row(children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0.018 * ScreenWidth,
                          0.07 * ScreenHeight,
                          0.13 * ScreenWidth,
                          0.02 * ScreenHeight),
                      child: Text(
                        'Chats',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'conthrax',
                            color: Colors.black,
                            fontSize: 0.066 * ScreenHeight),
                      ),
                    ),
                    ///////////////////////////////////Pic fetch///////////////////////////////
                    FutureBuilder(
                        future: MongoDB.getProfilePic(),
                        builder: (buildContext, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0, ScreenHeight * 0.054, 0, 0),
                                    width: ScreenWidth * 0.08,
                                    height: ScreenHeight * 0.08,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: FittedBox(
                                        fit: BoxFit
                                            .contain, // Set the fit property to BoxFit.contain to scale the image proportionally to fit inside the container
                                        child: CircleAvatar(
                                          backgroundColor: Colors.black,
                                        ))),
                              ],
                            );
                          } else if (snapshot.hasData) {
                            return Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0, ScreenHeight * 0.054, 0, 0),
                                    width: ScreenWidth * 0.08,
                                    height: ScreenHeight * 0.08,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: FittedBox(
                                        fit: BoxFit
                                            .contain, // Set the fit property to BoxFit.contain to scale the image proportionally to fit inside the container
                                        child: CircleAvatar(
                                          backgroundImage: snapshot.data,
                                        ))),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0, ScreenHeight * 0.054, 0, 0),
                                    width: ScreenWidth * 0.08,
                                    height: ScreenHeight * 0.08,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: FittedBox(
                                        fit: BoxFit
                                            .contain, // Set the fit property to BoxFit.contain to scale the image proportionally to fit inside the container
                                        child: CircleAvatar(
                                          backgroundColor: Colors.black,
                                        ))),
                              ],
                            );
                          }
                        }),
                  ]),
                  Container(
                    margin: EdgeInsets.only(
                        left: ScreenWidth * 0.0080,
                        top: ScreenHeight * 0.02,
                        bottom: ScreenHeight * 0.05),
                    height: ScreenHeight * 0.064,
                    width: ScreenWidth * 0.301,
                    decoration: BoxDecoration(
                      color: Paletter.mainBgLight,
                      border: Border.all(
                        color: Paletter.mainBgLight,
                      ),
                    ),
                    child: SearchInput(),
                    // ),
                  ),
                  Container(
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: null,
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered))
                              return Paletter.logInBg;
                            return null;
                          }),
                        ),
                        onPressed: () {
                          FutureBuilder(
                              future: MongoDB.getsalary(100001),
                              builder: (buildContext, AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.fromLTRB(
                                              0, ScreenHeight * 0.054, 0, 0),
                                          width: ScreenWidth * 0.08,
                                          height: ScreenHeight * 0.08,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: FittedBox(
                                              fit: BoxFit
                                                  .contain, // Set the fit property to BoxFit.contain to scale the image proportionally to fit inside the container
                                              child: CircleAvatar(
                                                backgroundColor: Colors.black,
                                              ))),
                                    ],
                                  );
                                } else if (snapshot.hasData) {
                                  return Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.fromLTRB(
                                              0, ScreenHeight * 0.054, 0, 0),
                                          width: ScreenWidth * 0.08,
                                          height: ScreenHeight * 0.08,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: FittedBox(
                                              fit: BoxFit
                                                  .contain, // Set the fit property to BoxFit.contain to scale the image proportionally to fit inside the container
                                              child: CircleAvatar(
                                                backgroundImage: snapshot.data,
                                              ))),
                                    ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.fromLTRB(
                                              0, ScreenHeight * 0.054, 0, 0),
                                          width: ScreenWidth * 0.08,
                                          height: ScreenHeight * 0.08,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: FittedBox(
                                              fit: BoxFit
                                                  .contain, // Set the fit property to BoxFit.contain to scale the image proportionally to fit inside the container
                                              child: CircleAvatar(
                                                backgroundColor: Colors.black,
                                              ))),
                                    ],
                                  );
                                }
                              });
                        },
                        child: Text(
                          'forgot password?',
                          style: TextStyle(
                              color: Paletter.logInText,
                              fontFamily: 'Neuropol'),
                        )),
                  ),
                  /*Container(
                        width: 300,
                        height: 50,
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey[700]),
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered))
                                  return Paletter.logInText;
                                return null;
                              }),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ))),
                          onPressed: () {
                            /*if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();*/
                            sendOtp();
                          },
                          child: const Text(
                            'Send OTP',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Neuropol',
                            ),
                          ),
                        )),
                    */
                  Row(children: [
                    Container(
                      child: FutureBuilder(
                          future: MongoDB.getInfo(),
                          builder: (buildContext, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error while fetching data');
                            } else if (snapshot.hasData) {
                              Uint8List photoBytes =
                                  base64Decode(snapshot.data['profilePicture']);
                              return InkWell(
                                  onTap: () {
                                    if (isVisible == true) {
                                      isVisible = false;
                                    } else {
                                      isVisible = true;
                                    }
                                  },
                                  child: MouseRegion(
                                      onEnter: (event) => onEntered(true),
                                      onExit: (event) => onEntered(false),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: (isHovered)
                                              ? Paletter.containerLight
                                              : Paletter.containerDark,
                                        ),
                                        margin: EdgeInsets.fromLTRB(
                                            ScreenWidth * 0.0067,
                                            ScreenHeight * 0,
                                            ScreenWidth * 0,
                                            ScreenHeight * 0.003),
                                        width: ScreenWidth * 0.392,
                                        height: ScreenHeight * 0.089,
                                        child: Row(children: [
                                          Container(
                                              margin: EdgeInsets.fromLTRB(0,
                                                  ScreenHeight * 0.00145, 0, 0),
                                              width: ScreenWidth * 0.063,
                                              height: ScreenHeight * 0.063,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: FittedBox(
                                                  fit: BoxFit
                                                      .contain, // Set the fit property to BoxFit.contain to scale the image proportionally to fit inside the container
                                                  child: CircleAvatar(
                                                    backgroundImage:
                                                        MemoryImage(photoBytes),
                                                  ))),
                                          SizedBox(
                                            width: ScreenWidth * 0.006,
                                          ),
                                          Center(
                                            child: Text(
                                              '${snapshot.data['name']}',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontFamily: 'Iceland',
                                                fontSize: 0.028 * ScreenHeight,
                                              ),
                                            ),
                                          ), //placeholder for picture
                                        ]),
                                      )));
                            } else {
                              return Container(
                                margin: EdgeInsets.fromLTRB(
                                    ScreenWidth * 0.405,
                                    ScreenHeight * 0.16,
                                    ScreenWidth * 0,
                                    ScreenHeight * 0),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }
                          }),
                    ),
                  ]),
                ]),
            Visibility(
                visible: isVisible,
                child: Container(
                  margin: EdgeInsets.fromLTRB(ScreenWidth * 0.01,
                      ScreenHeight * 0, ScreenWidth * 0, ScreenHeight * 0),
                  width: ScreenWidth * 0.001,
                  height: ScreenHeight * 0.8,
                  color: Colors.black,
                )),
            Visibility(
                visible: isVisible,
                child: Container(
                  margin: EdgeInsets.fromLTRB(ScreenWidth * 0.01,
                      ScreenHeight * 0, ScreenWidth * 0, ScreenHeight * 0),
                  width: ScreenWidth * 0.445,
                  height: ScreenHeight * 0.853,
                  color: Colors.white,
                )),
          ]),
        ),
      ]),
      Row(
        children: [
          TextField(
            controller: myController,
            decoration: InputDecoration(
              labelText: 'Enter your text here',
              border: OutlineInputBorder(),
            ),
          ),
          TextButton(
  onPressed: () {
    MongoDB.addMeeting('Meeting Subject');
  },
  child: Text('Create Meeting'),
)
        ],
      )
    ]));
  }
}
