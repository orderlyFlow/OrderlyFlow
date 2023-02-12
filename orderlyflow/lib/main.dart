import 'dart:io';
import 'package:flutter/material.dart';
import 'package:orderlyflow/chatPage.dart';
// import 'package:window_size/window_size.dart';
import 'LogIn/log_in.dart';
import 'loadingPage/home_screen.dart';
import 'Database/db.dart';
import 'package:orderlyflow/main_page.dart';


//const mongoDB_URL = "";
//const collName = "";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // setWindowMinSize(Size(1000, 600));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => mainPage(),
    },
  ));
}
