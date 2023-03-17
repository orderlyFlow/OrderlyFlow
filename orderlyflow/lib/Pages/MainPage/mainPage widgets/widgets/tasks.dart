import 'package:flutter/material.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';
import 'dart:async';

class tasks extends StatefulWidget {
  const tasks({super.key});
  @override
  State<tasks> createState() => _tasksState();
}

class _tasksState extends State<tasks> {
  @override
  Widget build(BuildContext context) {
    late double ScreenWidth = MediaQuery.of(context).size.width;
    late double ScreenHeight = MediaQuery.of(context).size.height;
    return Container(
        width: ScreenWidth * 0.397,
        height: ScreenHeight * 0.44,
        decoration: BoxDecoration(
            color: Paletter.containerLight,
            borderRadius: BorderRadius.circular(15)),
        child: Expanded(
            child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Container(
              height: ScreenHeight * 0.1,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Center(child: Text('Tasks')),
            );
          },
        )));
  }
}
