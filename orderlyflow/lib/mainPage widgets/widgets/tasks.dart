// ignore_for_file: unused_import, library_prefixes, camel_case_types, non_constant_identifier_names, prefer_const_constructors, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:orderlyflow/mainPage%20widgets/taskClass.dart';
import 'package:orderlyflow/palette.dart';
import 'dart:async';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import 'package:orderlyflow/Database/constant.dart';
import 'package:orderlyflow/tasks.dart';
import 'package:page_transition/page_transition.dart';

class tasks extends StatefulWidget {
  final List<Tasks> taskInfo;

  const tasks({super.key, required this.taskInfo});
  @override
  State<tasks> createState() => _tasksState();
}

class _tasksState extends State<tasks> {
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
    late double ScreenWidth = MediaQuery.of(context).size.width;
    late double ScreenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: ScreenWidth * 0.397,
      height: ScreenHeight * 0.44,
      decoration: BoxDecoration(
          color: Paletter.containerLight,
          borderRadius: BorderRadius.circular(15)),
      // child: Column(
      //   children: widget.taskInfo.map((e) => Text(e.name)).toList(),
      // ),

      child: ListView.builder(
        itemCount: widget.taskInfo.length,
        itemBuilder: (BuildContext, int index) {
          Tasks task = widget.taskInfo[index];
          return Card(
            child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  task.name,
                  style: TextStyle(
                    fontFamily: 'iceland',
                    fontSize: ScreenHeight * 0.03,
                    color: Paletter.blackText,
                    decoration: task.status
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                value: task.status,
                onChanged: (bool? value) {
                  if (value != null) {
                    updateTask(task.ID, value);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: value
                            ? Text('Task Complete')
                            : Text('Work In Progress')));
                  }

                }),
                
          );
        },
      ),
    );
  }
}
