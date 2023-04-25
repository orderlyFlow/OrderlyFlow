import 'package:flutter/material.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';

class BlueBg extends StatelessWidget {
  const BlueBg({super.key});

  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(ScreenWidth * 0.10),
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
    );
  }
}
