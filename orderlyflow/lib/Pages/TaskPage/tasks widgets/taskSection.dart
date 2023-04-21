// ignore: file_names
import 'package:flutter/material.dart';
import 'package:orderlyflow/Database/constant.dart';
import 'package:orderlyflow/Database/db.dart';
import 'package:orderlyflow/Pages/MainPage/tasks.dart';
import 'package:orderlyflow/Pages/TaskPage/tasks%20widgets/addTaskButton.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import 'package:page_transition/page_transition.dart';

import '../tasks.dart';

class userTasks extends StatefulWidget {
  List<Tasks> taskInfo;

  userTasks({super.key, required this.taskInfo});

  @override
  State<userTasks> createState() => _userTasksState();
}

class _userTasksState extends State<userTasks> {
  Future<void> updateTask(int id, bool status) async {
    var db = await Mongo.Db.create(mongoDB_URL);
    await db.open();
    var col = db.collection(tasksCol);
    await col.update(
        Mongo.where.eq('TaskID', id), Mongo.modify.set('status', status));

    final updatedTaskList = widget.taskInfo.map((task) {
      if (task.ID == id) {
        return task.copyWith(status: status);
      } else {
        return task;
      }
    }).toList();

    setState(() {
      // _taskInfo[index] = _taskInfo[index].copyWith(status: status);
      widget.taskInfo.clear();
      widget.taskInfo.addAll(updatedTaskList);
    });
  }

  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: ScreenHeight * 0.96,
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
                FutureBuilder(
                    future: MongoDB.getTeamName()  ,
                    builder: (buildContext, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error');
                      } else if (snapshot.hasData) {
                        return Container(
                          margin: EdgeInsets.only(top: ScreenHeight * 0.01),
                          child: Text(
                            '${snapshot.data['name']}',
                            style: TextStyle(
                                fontSize: ScreenHeight * 0.04,
                                fontFamily: 'conthrax',
                                color: Colors.black),
                          ),
                        );
                      } else {
                        return Text(
                          '',
                          style: TextStyle(
                              fontSize: ScreenHeight * 0.044,
                              fontFamily: 'conthrax',
                              color: Paletter.blackText),
                        );
                      }
                    }),
                // Text(
                //   'Development Team',
                //   style: TextStyle(
                //     color: Paletter.blackText,
                //     fontFamily: 'conthrax',
                //     fontSize: ScreenHeight * 0.033,
                //   ),
                // ),
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
                FutureBuilder(
                    future: MongoDB.getInfo(),
                    builder: (buildContext, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error');
                      } else if (snapshot.hasData) {
                        return Container(
                          margin: EdgeInsets.only(top: ScreenHeight * 0.01),
                          child: Text(
                            '${snapshot.data['name']}',
                            style: TextStyle(
                                fontSize: ScreenHeight * 0.044,
                                fontFamily: 'iceland',
                                color: Colors.black),
                          ),
                        );
                      } else {
                        return Text(
                          '',
                          style: TextStyle(
                              fontSize: ScreenHeight * 0.024,
                              fontFamily: 'iceland',
                              color: Colors.black),
                        );
                      }
                    }),
              ],
            ),
            SizedBox(
              height: ScreenHeight * 0.04,
            ),
            Row(
              children: [
                Text(
                  'Tasks',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Paletter.mainBg,
                      fontSize: ScreenHeight * 0.03,
                      fontFamily: "conthrax"),
                ),
                SizedBox(width: ScreenWidth * 0.3,),
               FutureBuilder(
                    future: Future.wait([MongoDB.getIds(), MongoDB.getInfo(), MongoDB.fetchNamesForIds()]),
                    builder: (buildContext, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else if (snapshot.hasData) {
                        int userID = snapshot.data[1]['ID'];
                        List<int> ids = snapshot.data[0] as List<int>;
                        List<String> names = snapshot.data[2] as List<String>;
                        return addTaskButton(ID: userID, ids: ids, names: names,);
                      } else {
                        return CircularProgressIndicator(
                          color: Colors.white,
                        );
                      }
                    }),
              ],
            ),
            SizedBox(
              height: ScreenHeight * 0.054,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.taskInfo.length,
                itemBuilder: (BuildContext, int index) {
                  final task = widget.taskInfo[index];
                  return Padding(
                    padding: EdgeInsets.only(top: ScreenHeight * 0.02),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Checkbox(
                            value: task.status,
                            onChanged: (bool? value) {
                              if (value != null) {
                                updateTask(task.ID, value);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: value
                                            ? Text('Task Complete')
                                            : Text('Work In Progress')));
                              }
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          myTasks(),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );
                            }),
                        // SizedBox(
                        //   width: 65,
                        // ),
                        Expanded(
                          child: Text(
                            task.name,
                            style: TextStyle(
                              fontFamily: 'iceland',
                              fontSize: ScreenHeight * 0.043,
                              color: Paletter.blackText,
                              decoration: task.status
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              ScreenWidth * 0.002,
                              ScreenHeight * 0.002,
                              ScreenWidth * 0.002,
                              ScreenHeight * 0.002),
                          height: ScreenHeight * 0.04,
                          width: ScreenWidth * 0.09,
                          decoration: BoxDecoration(
                            color: task.status
                                ? Color.fromRGBO(39, 174, 96, 1)
                                : Color.fromRGBO(231, 76, 60, 1),
                            borderRadius:
                                BorderRadius.circular(ScreenHeight * 0.005),
                          ),
                          child: Center(
                            child: Text(
                              task.status ? 'Complete' : 'Progress',
                              style: TextStyle(
                                  fontSize: ScreenHeight * 0.035,
                                  fontFamily: 'iceland',
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: ScreenWidth * 0.04,
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}