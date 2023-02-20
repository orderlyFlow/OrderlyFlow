// ignore: file_names
import 'package:flutter/material.dart';
import 'package:orderlyflow/mainPage widgets/dashboard.dart';
import 'package:orderlyflow/side_bar.dart';
import 'package:orderlyflow/palette.dart';

class mainPage extends StatelessWidget {
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
            Expanded(
              flex: 13,
              child: Dashboard()
              ),
          ],
        ),
      ),
    );
  }
}