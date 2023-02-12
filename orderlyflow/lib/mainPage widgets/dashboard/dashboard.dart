// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:orderlyflow/mainPage%20widgets/dashboard/widgets/annoucement.dart';
import 'package:orderlyflow/mainPage%20widgets/dashboard/widgets/calendar.dart';
import 'package:orderlyflow/mainPage%20widgets/dashboard/widgets/inbox.dart';
import 'package:orderlyflow/mainPage%20widgets/dashboard/widgets/tasks.dart';
import 'package:orderlyflow/palette.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Paletter.mainBgLight,
      child: Container(
        padding: EdgeInsets.all(20),
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
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20)
              )
        ),
        child: Row(
          children: [
            Column(
              children: [
                calendarMain(),
                SizedBox(height: 20,),
                inbox()
              ],
            ),
            // SizedBox(width: 10,),
            // Column(
            //   children: [
            //     announcement(),
            //     tasks()
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}