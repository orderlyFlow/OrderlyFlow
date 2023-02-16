import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:orderlyflow/palette.dart';
import 'package:orderlyflow/side_bar.dart';
import 'package:orderlyflow/task widgets/taskBoard.dart';

class myTasks extends StatefulWidget {
  const myTasks({super.key});

  @override
  State<myTasks> createState() => _myTasksState();
}

class _myTasksState extends State<myTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      backgroundColor: Paletter.mainBgLight,
      body: SafeArea(
        child: Row(            
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Side Access Bar
            Expanded(child: SideBar()),
            //Main Body part
            Expanded(
              flex: 7,
              child:taskBoard(),
              ),
          ],
        ),
      ),
    );
  }
}