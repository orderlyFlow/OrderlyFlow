// ignore_for_file: unnecessary_import, implementation_imports, unused_import, camel_case_types, use_key_in_widget_constructors, annotate_overrides, non_constant_identifier_names, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:orderlyflow/palette.dart';



class welcome extends StatefulWidget {
  final String name;  

  const welcome({required this.name});
  @override
  State<welcome> createState() => _welcomeState();
}



class _welcomeState extends State<welcome> {
  


  Widget build(BuildContext context) {
      late double ScreenWidth = MediaQuery.of(context).size.width;
  late double ScreenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: ScreenWidth * 0.397,
      height: ScreenHeight * 0.5,
      decoration: BoxDecoration(
          color: Paletter.containerDark,
          borderRadius: BorderRadius.circular(15)),
      child:Container(
              height: ScreenHeight * 0.4,
              width: ScreenWidth * 0.4,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/OF.gif",
                    height: ScreenHeight * 0.35,
                    width: ScreenWidth * 0.35,),
                    SizedBox(height: ScreenHeight * 0.001,),
                    Text(
                      "Hello ${widget.name}",
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'conthrax'
                      ),
                    ),
                    SizedBox(height: ScreenHeight * 0.002,),
                    Text(
                      'Your tasks are ready',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'iceland'
                      ),
                    )
                  ],
                ),
              ),
            )
      
    );
  }
}