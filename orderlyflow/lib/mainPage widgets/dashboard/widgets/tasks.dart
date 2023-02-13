import 'package:flutter/material.dart';
import 'package:orderlyflow/palette.dart';
import 'dart:async';

class tasks extends StatefulWidget {

  final String name;

  const tasks({required this.name});
  @override
  State<tasks> createState() => _tasksState();
}

class _tasksState extends State<tasks> {

  bool showTasks = false;

  void initState(){
    super.initState();
    Timer(Duration(seconds: 5), (){
      setState(() {
        showTasks = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 505,
      height: 305,
      decoration: BoxDecoration(
        color: Paletter.containerLight,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        children: [
          showTasks ? Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return Container(
                  height: 50,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text('Tasks')),
                ) ;
              },
            )
            ) : Container(
              height: 300,
              width: 305,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/OF.gif",
                    height: 100,
                    width: 100,),
                    SizedBox(height: 10,),
                    Text(
                      "Hello ${widget.name}",
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'conthrax'
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      'Your tasks are ready',
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'iceland'
                      ),
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}