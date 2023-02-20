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
  late double ScreenWidth = MediaQuery.of(context).size.width;
  late double ScreenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: ScreenWidth * 0.397,
      height: ScreenHeight * 0.44,
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
                  height: ScreenHeight * 0.1,
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
              height: ScreenHeight * 0.4,
              width: ScreenWidth * 0.4,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/OF.gif",
                    height: ScreenHeight * 0.25,
                    width: ScreenWidth * 0.25,),
                    SizedBox(height: ScreenHeight * 0.001,),
                    Text(
                      "Hello ${widget.name}",
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'conthrax'
                      ),
                    ),
                    SizedBox(height: ScreenHeight * 0.001,),
                    Text(
                      'Your tasks are ready',
                      style: TextStyle(
                        fontSize: 12,
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