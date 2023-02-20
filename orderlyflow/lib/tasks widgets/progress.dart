import 'package:flutter/material.dart';
import 'package:orderlyflow/palette.dart';


class userProgress extends StatefulWidget {
  const userProgress({super.key});

  @override
  State<userProgress> createState() => _userProgressState();
}

class _userProgressState extends State<userProgress> {
  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: ScreenHeight * 0.34,
      width: ScreenWidth * 0.4,
      decoration: BoxDecoration(
        color: Paletter.containerDark,
        borderRadius: BorderRadius.circular(15)
      ),
    );
  }
}