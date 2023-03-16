// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';

import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import 'package:orderlyflow/Database/constant.dart';
import 'package:orderlyflow/Database/db.dart';
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
      Row(
        children: [
          SideBar(),
          Container(
              margin: EdgeInsets.fromLTRB(0.03 * ScreenWidth,
                  0.02 * ScreenHeight, 0.02 * ScreenWidth, 0),
              height: ScreenHeight * 0.90,
              width: ScreenWidth * 0.88,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Paletter.mainBgLight,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0.03 * ScreenWidth,
                            0.07 * ScreenHeight,
                            0.18 * ScreenWidth,
                            0.03 * ScreenHeight),
                        child: const Text(
                          'Chats',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'conthrax',
                              color: Colors.black,
                              fontSize: 38),
                        ),
                      ),
                      ///////////////////////////////////Pic fetch///////////////////////////////
                      FutureBuilder(
                          future: MongoDB.getProfilePic(),
                          builder: (buildContext, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            } else if (snapshot.hasData) {
                              return Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0, ScreenHeight * 0.032, 0, 0),
                                      child: InkWell(
                                          child: Image.memory(
                                        snapshot.data,
                                        width: ScreenWidth * 0.07,
                                        height: ScreenHeight * 0.07,
                                        alignment: Alignment.center,
                                      ))),
                                ],
                              );
                            } else {
                              return Container(
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }
                          }),
                      ///////////////////////Photo Placeholder///////////////////
                      /* Container(
                        margin:
                            EdgeInsets.fromLTRB(0, ScreenHeight * 0.032, 0, 0),
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: ScreenWidth * 0.07,
                          height: ScreenHeight * 0.07,
                          alignment: Alignment.center,
                        ),
                      )*/
                    ]),
                    Container(
                      margin: EdgeInsets.only(
                          left: ScreenWidth * 0.0080,
                          top: ScreenHeight * 0.02,
                          bottom: ScreenHeight * 0.05),
                      height: ScreenHeight * 0.064,
                      width: ScreenWidth * 0.34,
                      decoration: BoxDecoration(
                        color: Paletter.mainBgLight,
                        border: Border.all(
                          color: Paletter.mainBgLight,
                        ),
                      ),
                      child: SearchInput(),
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
                    Container(
                      child: FutureBuilder(
                          future: MongoDB.getInfo(),
                          builder: (buildContext, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            } else if (snapshot.hasData) {
                              return InkWell(
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
                                            ScreenWidth * 0.0078,
                                            ScreenHeight * 0,
                                            ScreenWidth * 0.2,
                                            ScreenHeight * 0.014),
                                        width: ScreenWidth * 0.42,
                                        height: ScreenHeight * 0.089,
                                        child: Row(children: [
                                          SizedBox(
                                            width: ScreenWidth * 0.0015,
                                          ),
                                          Text(
                                            '${snapshot.data['phone']}',
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'Iceland',
                                              fontSize: 18,
                                            ),
                                          ),
                                          SizedBox(
                                            width: ScreenWidth * 0.006,
                                          ),
                                          Center(
                                            child: Text(
                                              '${snapshot.data['name']}',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontFamily: 'Iceland',
                                                fontSize: 22,
                                              ),
                                            ),
                                          ), //placeholder for picture
                                        ]),
                                      )));
                            } else {
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }
                          }),
                    )
                  ]))
        ],
      )
    ]));
  }
}
