// ignore: file_names
import 'package:flutter/material.dart';
import 'package:orderlyflow/palette.dart';

class userTasks extends StatefulWidget {
  const userTasks({super.key});

  @override
  State<userTasks> createState() => _userTasksState();
}

class _userTasksState extends State<userTasks> {
  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: ScreenHeight * 0.49,
      width: ScreenWidth * 0.5,
      decoration: BoxDecoration(
          color: Paletter.containerLight,
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.02 * ScreenWidth, 0.02 * ScreenHeight,
            0.02 * ScreenWidth, 0.02 * ScreenHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Development Team',
                  style: TextStyle(
                    color: Paletter.blackText,
                    fontFamily: 'conthrax',
                    fontSize: 33,
                  ),
                ),
                SizedBox(
                  width: ScreenWidth * 0.02,
                ),
                Container(
                  margin: EdgeInsets.only(top: ScreenHeight * 0.01),
                  height: ScreenHeight * 0.015,
                  width: ScreenWidth * 0.0075,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(27, 79, 114, 1),
                      borderRadius: BorderRadius.circular(80)),
                ),
                SizedBox(
                  width: ScreenWidth * 0.02,
                ),
                Container(
                  margin: EdgeInsets.only(top: ScreenHeight * 0.01),
                  child: Text(
                    'Insert Name',
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'iceland',
                        color: Colors.black),
                  ),
                )
              ],
            ),
            SizedBox(
              height: ScreenHeight * 0.05,
            ),
            Text(
              'Tasks',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Paletter.mainBg,
                  fontSize: 24,
                  fontFamily: "conthrax"),
            ),
            SizedBox(
              height: ScreenHeight * 0.054,
            ),
            SingleChildScrollView(
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
