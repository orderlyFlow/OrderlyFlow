import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:orderlyflow/palette.dart';
import 'package:orderlyflow/side_bar.dart';
import 'package:orderlyflow/tasks widgets/taskSection.dart';
import 'package:orderlyflow/tasks%20widgets/commenst.dart';
import 'package:orderlyflow/tasks%20widgets/notes.dart';
import 'package:orderlyflow/tasks%20widgets/progress.dart';

import 'custom_widgets/BlueBg.dart';

class myTasks extends StatefulWidget {
  const myTasks({super.key});

  @override
  State<myTasks> createState() => _myTasksState();
}

class _myTasksState extends State<myTasks> {
  @override
  Widget build(BuildContext context) {
    late double ScreenWidth = MediaQuery.of(context).size.width;
    late double ScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(children: [
        const BlueBg(),
        Row(
          children: [
            SideBar(),
            Container(
                padding: EdgeInsets.fromLTRB(0.01 * ScreenWidth,
                    0.02 * ScreenHeight, 0.01 * ScreenWidth, 0.02 * ScreenHeight),
                child: Column(children: [
                  Row(children: [
                    Column(
                      children: [
                        userTasks(),
                        SizedBox(
                          height: ScreenHeight * 0.02,
                        ),
                        comments()
                      ],
                    ),
                    SizedBox(
                      width: ScreenWidth * 0.01,
                    ),
                    Column(
                      children: [
                        userProgress(),
                        SizedBox(
                          height: ScreenHeight * 0.02,
                        ),
                        notes()
                      ],
                    )
                  ]),
                ]))
          ],
        )
      ]),
    );
    
  }
}
