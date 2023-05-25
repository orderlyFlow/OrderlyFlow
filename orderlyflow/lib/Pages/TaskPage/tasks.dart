import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:orderlyflow/Database/db.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';
import 'package:orderlyflow/custom_widgets/side_bar.dart';
import 'package:orderlyflow/Pages/TaskPage/tasks%20widgets/taskSection.dart';
import 'package:orderlyflow/Pages/TaskPage/tasks%20widgets/addTaskButton.dart';
import 'package:orderlyflow/Pages/TaskPage/tasks%20widgets/notes.dart';
import 'package:orderlyflow/Pages/TaskPage/tasks%20widgets/progress.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../Database/textControllers.dart';
import '../../custom_widgets/BlueBg.dart';

class myTasks extends StatefulWidget {
  const myTasks({super.key});

  @override
  State<myTasks> createState() => _myTasksState();
}

class _myTasksState extends State<myTasks> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // Call setState to rebuild the widget tree
    // setState(() {});
    // Call refreshCompleted() when you're done refreshing the data
    _refreshController.refreshCompleted();
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (BuildContext context) => myTasks()),
    // );

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => myTasks(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    late double ScreenWidth = MediaQuery.of(context).size.width;
    late double ScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: Stack(children: [
          const BlueBg(),
          Row(
            children: [
              SideBar(),
              Container(
                  padding: EdgeInsets.fromLTRB(
                      0.01 * ScreenWidth,
                      0.02 * ScreenHeight,
                      0.01 * ScreenWidth,
                      0.02 * ScreenHeight),
                  child: Column(children: [
                    Row(children: [
                      Column(
                        children: [
                          userTasks(taskInfo: StoreController.renderedTasks),
                        ],
                      ),
                      SizedBox(
                        width: ScreenWidth * 0.01,
                      ),
                      Column(
                        children: [
                          userProgress(taskInfo: StoreController.renderedTasks),
                          SizedBox(
                            height: ScreenHeight * 0.02,
                          ),
                          FutureBuilder(
                              future: MongoDB.getNotes(),
                              builder: (buildContext, AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                } else if (snapshot.hasData) {
                                  int id = snapshot.data['noteID'];
                                  String notesText = snapshot.data['content'];
                                  return notes(content: notesText, noteId: id);
                                } else {
                                  return Container(
                                      height: ScreenHeight * 0.599,
                                      width: ScreenWidth * 0.4,
                                      decoration: BoxDecoration(
                                          color: Paletter.containerDark,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ));
                                }
                              }),
                        ],
                      )
                    ]),
                  ]))
            ],
          )
        ]),
      ),
    );
  }
}
