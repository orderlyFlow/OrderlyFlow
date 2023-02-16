// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:orderlyflow/mainPage widgets/widgets/annoucement.dart';
import 'package:orderlyflow/mainPage widgets/widgets/calendar.dart';
import 'package:orderlyflow/mainPage widgets/widgets/inbox.dart';
import 'package:orderlyflow/mainPage widgets/widgets/tasks.dart';
import 'package:orderlyflow/palette.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late double ScreenWidth = MediaQuery.of(context).size.width;
  late double ScreenHeight = MediaQuery.of(context).size.height;
  late final List<AnnouncementData> announcements;
  late String name;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Paletter.mainBgLight,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 2),
              // ignore: prefer_const_literals_to_create_immutables
              colors: <Color>[
                Paletter.gradiant1,
                //Paletter.gradiant2,
                Paletter.gradiant3,
                Paletter.mainBg,
              ], // Gradient
              tileMode: TileMode.clamp,
            ),
           ),
        child: Row(
          children: [
            Column(
              children: [
                calendarMain(),
                SizedBox(
                  height: ScreenHeight * 0.02,
                ),
                inbox()
              ],
            ),
            SizedBox(
              width: ScreenWidth * 0.01,
            ),
            Column(
              children: [
                Container(
                  width: ScreenWidth * 0.36,
                  height: ScreenHeight * 0.5,
                  decoration: BoxDecoration(
                      color: Paletter.containerDark,
                      borderRadius: BorderRadius.circular(15)),
                ),
                // announcement(announcements: announcements,),
                SizedBox(
                  height: ScreenHeight * 0.02,
                ),
                tasks(
                  name: 'Rai',
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}