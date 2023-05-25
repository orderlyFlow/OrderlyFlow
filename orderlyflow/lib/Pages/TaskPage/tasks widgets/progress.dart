import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:orderlyflow/Database/textControllers.dart';
import 'package:orderlyflow/Pages/MainPage/tasks.dart';
import 'package:orderlyflow/Pages/UserInfoPage/employeeData.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import 'package:orderlyflow/Database/db.dart';

class userProgress extends StatefulWidget {
  final List<Tasks> taskInfo;

  userProgress({super.key, required this.taskInfo});

  @override
  State<userProgress> createState() => _userProgressState();
}

class _userProgressState extends State<userProgress> {
  List<bool> values = [];
  double percent = 0.0;

  @override
  void initState() {
    super.initState();
    for (var task in widget.taskInfo) {
      values.add(task.status!);
    }
    int trueCount = values.where((element) => element == true).length;
    percent = trueCount / values.length;
  }

  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    final photoData = StoreController.currentUser!['profilePicture'];
    Uint8List photoBytes = base64Decode(photoData);
    ImageProvider imageProvider = MemoryImage(photoBytes);
    return Container(
      height: ScreenHeight * 0.34,
      width: ScreenWidth * 0.4,
      decoration: BoxDecoration(
          color: Paletter.containerDark,
          borderRadius: BorderRadius.circular(ScreenHeight * 0.02)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.00000001 * ScreenWidth,
            0.04 * ScreenHeight, 0.02 * ScreenWidth, 0.02 * ScreenHeight),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            childCurrent: const employeeData(),
                            child: employeeData(),
                            type: PageTransitionType.theme,
                            duration: const Duration(seconds: 2)));
                  },
                  child: Container(
                      width: ScreenWidth * 0.1,
                      height: ScreenHeight * 0.1,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: FittedBox(
                          fit: BoxFit
                              .contain, // Set the fit property to BoxFit.contain to scale the image proportionally to fit inside the container
                          child: CircleAvatar(
                            backgroundImage: imageProvider,
                          ))),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        StoreController.currentUser!['name'],
                        style: TextStyle(
                            fontSize: ScreenHeight * 0.03,
                            fontFamily: 'conthrax',
                            color: Paletter.blackText),
                      ),
                    ),
                    SizedBox(
                      height: ScreenHeight * 0.02,
                    ),
                    Container(
                      child: Text(
                        StoreController.currentUser!['jobDescription'],
                        style: TextStyle(
                            fontSize: ScreenHeight * 0.02,
                            fontFamily: 'iceland',
                            color: Paletter.blackText),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: ScreenHeight * 0.04,
            ),
            Center(
              child: Container(
                width: ScreenWidth * 0.25,
                child: LinearProgressIndicator(
                  value: percent,
                  backgroundColor: Color.fromRGBO(231, 76, 60, 1),
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(39, 174, 96, 1)),
                  semanticsLabel: '${(percent * 100).toStringAsFixed(0)}% true',
                  semanticsValue: '${(percent * 100).toStringAsFixed(0)}%',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
