import 'package:flutter/material.dart';
import 'package:orderlyflow/palette.dart';

class notes extends StatefulWidget {
  const notes({super.key});

  @override
  State<notes> createState() => _notesState();
}

class _notesState extends State<notes> {
  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: ScreenHeight * 0.59,
      width: ScreenWidth * 0.4,
      decoration: BoxDecoration(
        color: Paletter.containerLight,
        borderRadius: BorderRadius.circular(15)
      ),
    );
  }
}