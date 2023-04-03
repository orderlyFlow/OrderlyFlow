//ignore_for_file: depend_on_referenced_packages, unused_import, library_private_types_in_public_api, duplicate_ignore, annotate_overrides, unused_local_variable, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orderlyflow/palette.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  // ignore: prefer_const_constructors
  // ignore: prefer_const_literals_to_create_immutables
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: non_constant_identifier_names

  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Paletter.mainBgLight,
      body: Column(children: [
        Center(
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 55, 0, 0),
            child: Image.asset(
              'assets/images/logo.png',
              width: 250,
              height: 260,
              alignment: Alignment.center,
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(
              height: 70.0,
            ),
            Text(
              "O",
              style: TextStyle(
                fontSize: 55,
                color: Colors.white,
                fontFamily: 'neuropol',
              ),
            ),
            // ignore: prefer_const_constructors
            // SizedBox(
            // height: 25.0,
            //  ),
            // ignore: prefer_const_constructors
            Text(
              "derly  Flow",
              // ignore: prefer_const_constructors
              style: TextStyle(
                fontSize: 55,
                color: Paletter.mainBg,
                fontFamily: 'neuropol',
              ),
            ),
          ],
        ),
        // ignore: prefer_const_constructors
        SizedBox(
          height: 50,
        ),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(522, 0, 0, 20),
                  isThreeLine: false,
                  leading: LoadingAnimationWidget.newtonCradle(
                    // ignore: prefer_const_constructors
                    color: Paletter.mainBg,
                    size: 300,
                    //duration: const Duration(milliseconds: 250),
                  )),
              const Text(
                "loading .....",
                style: TextStyle(
                  fontSize: 25,
                  color: Paletter.mainBg,
                  fontFamily: 'neuropol',
                ),
              ),
            ]),
        // ignore: prefer_const_constructors
        SizedBox(
          height: 70.0,
        ),
      ]),
    );
  }
}
