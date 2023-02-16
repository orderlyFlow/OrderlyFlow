import 'package:flutter/material.dart';
import 'package:orderlyflow/palette.dart';

class comments extends StatefulWidget {
  const comments({super.key});

  @override
  State<comments> createState() => _commentsState();
}

class _commentsState extends State<comments> {
  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: ScreenHeight * 0.44,
      width: ScreenWidth * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Paletter.containerDark,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.02 * ScreenWidth, 0.02 * ScreenHeight,
            0.02 * ScreenWidth, 0.02 * ScreenHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: ScreenWidth * 0.0015),
              child: Text(
                'Comments',
                style: TextStyle(
                  color: Paletter.blackText.withOpacity(0.6),
                  fontFamily: "iceland",
                  fontSize: 35
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
