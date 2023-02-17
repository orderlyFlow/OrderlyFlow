import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:orderlyflow/palette.dart';
import 'package:orderlyflow/side_bar.dart';
import 'package:orderlyflow/calendar widgets/dates.dart';

import 'custom_widgets/BlueBg.dart';

class calendar extends StatefulWidget {
  const calendar({super.key});

  @override
  State<calendar> createState() => _calendarState();
}

class _calendarState extends State<calendar> {
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
                  calendarDate()
                ]))
          ],
        )
      ]),
    );
  }
}