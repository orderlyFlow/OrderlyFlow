// ignore: file_names
// ignore_for_file: use_key_in_widget_constructors, camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:orderlyflow/mainPage widgets/dashboard.dart';
import 'package:orderlyflow/side_bar.dart';
import 'package:orderlyflow/palette.dart';

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
