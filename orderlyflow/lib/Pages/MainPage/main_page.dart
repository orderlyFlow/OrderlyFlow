// ignore: file_names
import 'package:flutter/material.dart';
import 'package:orderlyflow/Pages/MainPage/mainPage%20widgets/dashboard.dart';
import 'package:orderlyflow/custom_widgets/side_bar.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';

class mainPage extends StatefulWidget {
  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      backgroundColor: Paletter.mainBgLight,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Side Access Bar
            Expanded(child: SideBar()),
            // Main Body part
            Expanded(flex: 13, child: Dashboard()),
          ],
        ),
      ),
    );
  }
}
