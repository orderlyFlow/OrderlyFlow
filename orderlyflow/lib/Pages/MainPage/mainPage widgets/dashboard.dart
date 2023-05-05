// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:orderlyflow/Database/textControllers.dart';
import 'package:orderlyflow/Pages/MainPage/mainPage%20widgets/widgets/welcome.dart';
import 'package:orderlyflow/Pages/MainPage/mainPage%20widgets/widgets/calendar.dart';
import 'package:orderlyflow/Pages/MainPage/mainPage%20widgets/widgets/inbox.dart';
import 'package:orderlyflow/Pages/MainPage/mainPage%20widgets/widgets/tasks.dart';
import 'package:orderlyflow/Pages/MainPage/tasks.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';

import '../../../Database/db.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void getAllTasks() async {
    StoreController.renderedTasks = await MongoDB.getTask();
  }

  @override
  Widget build(BuildContext context) {
    late double ScreenWidth = MediaQuery.of(context).size.width;
    late double ScreenHeight = MediaQuery.of(context).size.height;
    String UserName = StoreController.currentUser!['name'];
    getAllTasks();
    return Material(
      color: Paletter.mainBgLight,
      child: Container(
        padding: EdgeInsets.fromLTRB(
            0.01 * ScreenWidth, 0.02 * ScreenHeight, 0.01 * ScreenWidth, 0),
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
                welcome(name: UserName),
                SizedBox(
                  height: ScreenHeight * 0.02,
                ),
                tasks(taskInfo: StoreController.renderedTasks),
              ],
            )
          ],
        ),
      ),
    );
  }
}
