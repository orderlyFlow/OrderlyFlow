import 'package:flutter/material.dart';
import 'package:orderlyflow/palette.dart';
import 'package:orderlyflow/custom_widgets/searchBar.dart';

class chatPage extends StatefulWidget {
  const chatPage({super.key});

  @override
  State<chatPage> createState() => chatPageState();
}

// ignore: prefer_const_constructors
class chatPageState extends State<chatPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 2),
              colors: <Color>[
                Paletter.gradiant1,
                //Paletter.gradiant2,
                Paletter.gradiant3,
                Paletter.mainBg,
              ], // Gradient
              tileMode: TileMode.clamp,
            ),
          ),
          child: Container(
              margin: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Paletter.mainBgLight,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(22, 22, 0, 2),
                      child: const Text(
                        'Chats',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'conthrax',
                            fontSize: 38),
                      ),
                    ),
                    Container(child: SearchInput()),
                  ]))),
    );
  }
}
