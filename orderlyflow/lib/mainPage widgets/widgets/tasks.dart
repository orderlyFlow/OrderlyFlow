import 'package:flutter/material.dart';
import 'package:orderlyflow/palette.dart';
import 'dart:async';

class tasks extends StatefulWidget {

  final List <String> taskInfo;


  const tasks({super.key, required this.taskInfo});
  @override
  State<tasks> createState() => _tasksState();
}

class _tasksState extends State<tasks> {

  bool isChecked = false;



  void _showSnackBar (String msg){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(seconds: 2),
      )
    );
  }


  Widget template(task){
    return Card(
      margin: EdgeInsets.all(10),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Center(
          child: Row(
            children: [
              Checkbox(
                value: isChecked, 
                onChanged: (bool? value){
                  setState(() {
                    isChecked = value!;
                    if(isChecked){
                      _showSnackBar('Complete');
                    } else {
                      _showSnackBar('Not Actually Complete');
                    }
                  });
                }
                ),
              Text(
                '${task}',
                style: TextStyle(
                  decoration: isChecked ? TextDecoration.lineThrough : null,
                ),
              ),
            ],
          ),
        )
        ),
      );
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
        borderRadius: BorderRadius.circular(15)
      ),
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: widget.taskInfo.map((task) => template(task)).toList(),
          ),
        ),
      ) 
    );
  }
}