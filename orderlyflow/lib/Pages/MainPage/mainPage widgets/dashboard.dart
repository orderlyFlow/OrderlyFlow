// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:orderlyflow/Pages/MainPage/mainPage%20widgets/widgets/welcome.dart';
import 'package:orderlyflow/Pages/MainPage/mainPage%20widgets/widgets/calendar.dart';
import 'package:orderlyflow/Pages/MainPage/mainPage%20widgets/widgets/inbox.dart';
import 'package:orderlyflow/Pages/MainPage/mainPage%20widgets/widgets/tasks.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';

import '../../../Database/db.dart';
import '../../../Database/textControllers.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void fetchTasks() async {
    if (StoreController.renderedTasks.isEmpty) {
      StoreController.renderedFutureTasks = MongoDB.getTask();
      //StoreController.renderedTasks = await MongoDB.getTask();
    }
  }

  @override
  Widget build(BuildContext context) {
    late double ScreenWidth = MediaQuery.of(context).size.width;
    late double ScreenHeight = MediaQuery.of(context).size.height;
    fetchTasks();
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
                welcome(name: StoreController.currentUser!['name']),
                SizedBox(
                  height: ScreenHeight * 0.02,
                ),
                FutureBuilder(
                    future: StoreController.renderedFutureTasks,
                    builder: (buildContext, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else if (snapshot.hasData) {
                        return tasks(taskInfo: StoreController.renderedTasks);
                      } else {
                        return Container(
                            width: ScreenWidth * 0.397,
                            height: ScreenHeight * 0.44,
                            decoration: BoxDecoration(
                                color: Paletter.containerLight,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ));
                      }
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
